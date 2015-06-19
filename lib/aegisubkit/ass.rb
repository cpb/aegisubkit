require 'treetop'

module Aegisubkit
  module ASS
    class Subtitle < Treetop::Runtime::SyntaxNode
    end

    class ScriptInfo < Treetop::Runtime::SyntaxNode
    end

    class AudioMetaData < Treetop::Runtime::SyntaxNode
    end

    class V4PStyles < Treetop::Runtime::SyntaxNode

    end

    class Events < Treetop::Runtime::SyntaxNode
      def build
        elements.map do |line|
          subtitle = {}

          fields = line.text_value.split(',')

          subtitle[:id] = elements.index(line) + 1
          subtitle[:start] = SSA.parse_timecode(fields[1])
          subtitle[:end] = SSA.parse_timecode(fields[2])
          subtitle[:lines] = fields[9..-1].join.gsub('\N', "\n")

          subtitle
        end
      end
    end

    def self.import(string)
      Treetop.load(File.join(__dir__, 'ass'))
      parser = ASSParser.new
      syntax_tree = parser.parse(string)

      if syntax_tree
        return syntax_tree.build
      else
        failure = "failure_index #{parser.failure_index}\n"
        failure += "failure_line #{parser.failure_line}\n"
        failure += "failure_column #{parser.failure_column}\n"
        failure += "failure_reason #{parser.failure_reason}\n"

        raise failure
      end
    end
  end
end
