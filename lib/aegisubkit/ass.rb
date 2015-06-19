require 'treetop'

module Aegisubkit
  module ASS
    class Subtitle < Treetop::Runtime::SyntaxNode
      def build
        subtitle = {}
        subtitle[:events] = event_section.events.build
        subtitle[:info] = info.build
        subtitle[:audio_metadata] = audio_metadata.build
        subtitle
      end
    end

    class ScriptInfo < Treetop::Runtime::SyntaxNode
      def build
        elements.map do |line|
          line.text_value
        end.join
      end
    end

    class AudioMetaData < Treetop::Runtime::SyntaxNode
      def build
        elements.map do |line|
          next if line.text_value =~ /\[Aegisub Project Garbage\]/
          next if line.text_value == '/n'
          ary = line.text_value.split(/\n/).map do |x|
            a = x.split(':')
            a[0] = a.first.to_s.downcase.sub(/\s/, '_')
            a.map(&:strip)
          end.flatten
          h = Hash[*ary]
          h unless h.empty?
        end.compact.first
      end
    end

    class V4PStyles < Treetop::Runtime::SyntaxNode
      def build
        elements.map { |line| line.text_value }.join
      end
    end

    class Events < Treetop::Runtime::SyntaxNode
      def build
        elements.map do |line|
          events = {}

          fields = line.text_value.split(',')

          events[:id] = elements.index(line) + 1
          # subtitle[:start] = SSA.parse_timecode(fields[1])
          # subtitle[:end] = SSA.parse_timecode(fields[2])
          events[:lines] = fields[9..-1].join.sub!(/\N|\n/, '')

          events
        end
      end
    end

    def self.import(file_path)
      Treetop.load(File.join(__dir__, 'ass'))
      parser = ASSParser.new
      string = File.read(file_path, encoding: 'bom|utf-8')
      syntax_tree = parser.parse(string)
      if syntax_tree
        syntax_tree.build
      else
        failure = "failure_index #{parser.failure_index}\n"
        failure += "failure_line #{parser.failure_line}\n"
        failure += "failure_column #{parser.failure_column}\n"
        failure += "failure_reason #{parser.failure_reason}\n"

        fail failure
      end
    end
  end
end
