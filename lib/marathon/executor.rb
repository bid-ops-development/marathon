# frozen_string_literal: true

require "forwardable"
require_relative "bash_driver"

module Marathon
  # Command execution service.
  # Main contract here is that executor implements
  # #shell to run a string as a shell command.
  class Executor
    extend Forwardable
    def_delegator :driver, :run, :shell

    private

    def driver
      @driver ||= Marathon::BashDriver.new
    end
  end
end
