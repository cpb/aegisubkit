require 'aegisubkit/version'
require 'aegisubkit/logger'

module Aegisubkit
  autoload :ASS, 'aegisubkit/ass'

  def self.logger
    Aegisubkit::Logger.new
  end
end
