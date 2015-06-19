require 'spec_helper'

describe Aegisubkit::ASS do
  before do
    # binding.pry
    Treetop.load File.expand_path('../../../lib/aegisubkit/ass', __FILE__)
    @content = File.read File.expand_path('../../fixtures/example.ass', __FILE__)
  end

  it 'should run this' do
    parser = ASSParser.new
    r = parser.parse @content
    puts @content
    if !r
      puts parser.failure_reason
      puts parser.failure_line
      puts parser.failure_column
    end
  end
end
