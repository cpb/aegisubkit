require 'logger'
require 'aegisubkit/version'

module Aegisubkit
  autoload :ASS, 'aegisubkit/ass'

  def self.logger=(log)
    @logger = log
  end

  def self.logger
    return @logger if @logger
    logger = ::Logger.new(STDOUT)
    logger.level = ::Logger::INFO
    @logger = logger
  end
end
