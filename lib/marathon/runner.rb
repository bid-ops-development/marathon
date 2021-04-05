require_relative "executor"
require_relative "wrappers"

module Marathon
  module Basics
    def say(message)
      dispatch "echo '#{message}'"
    end
  end

  class Runner
    include Wrappers
    include Basics
    def check; puts "=== Implement a check strategy ===" end
    def clean; puts "=== Implement a clean strategy ===" end
    def test; puts "=== Implement a test strategy ===" end
    def start; puts "=== Implement a boot strategy ===" end
    def verify; clean; check; test end
    def all; verify; start end

    def main(arguments)
      command = arguments[0] || 'all'
      if arguments.length > 1
        subcommand_arguments = arguments[1..-1]
        send(command, subcommand_arguments.join(' ').chomp)
      else
        send(command)
      end
    end

    def executor
      @executor ||= Executor.new
    end

    protected

    def dispatch(command)
      executor.shell command.to_s
    end
    alias :run :dispatch
  end
end
