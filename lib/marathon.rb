# frozen_string_literal: true

require_relative "marathon/version"
require_relative "marathon/runner"

##
#
# Marathon is a microtask runner framework.
#
# Built with <3 at Bid Ops
#
module Marathon
  class Error < StandardError; end

  Result = Struct.new(:successful, :output, keyword_init: true) do
    def successful?
      !!successful
    end
  end

  def self.run(command)
    Runner.new.send :dispatch, command
  end
end
