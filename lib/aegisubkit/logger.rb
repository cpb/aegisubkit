module Aegisubkit
  class Logger
    def initialize(logger = nil, options = {})
      @logger = logger || begin
                            require 'logger'
                            ::Logger.new(STDOUT)
                          end
    end
  end
end
