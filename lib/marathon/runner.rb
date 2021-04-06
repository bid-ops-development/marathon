# frozen_string_literal: true

require_relative "executor"
require_relative "wrappers"
require_relative "basics"
require_relative "dsl"

module Marathon
  # Task runner base class with command-builder DSL and tool wrapper definitions
  class Runner
    extend DSL
    include Basics
    include Wrappers

    %w[setup check clean test start].each do |phase|
      define_method(phase) do
        say "=== (TODO) Implement a #{phase} strategy ==="
      end
    end

    def verify
      clean
      check
      test
    end

    def all
      setup
      verify
      start
    end

    def help
      say "Available commands: #{available_commands.join(", ")}"
    end

    def main(arguments)
      command = arguments[0] || "all"

      if arguments.length > 1
        subcommand_arguments = arguments[1..-1]
        send(command, subcommand_arguments.join(" ").chomp)
      else
        send(command)
      end
    end

    protected

    def available_commands
      boring_commands = %i[
        available_commands
        main dispatch run all help
        say warn ok echo
        yarn jest
        rails jest rspec rake bundle
        rubocop cop guard
      ]
      available = methods - Object.new.methods - boring_commands
      available.sort
    end

    def dispatch(command = 'echo "(hello from marathon)"')
      executor.shell command.to_s
    end
    alias run dispatch

    private

    def executor
      @executor ||= Executor.new
    end
  end
end
