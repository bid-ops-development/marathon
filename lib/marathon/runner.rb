require_relative "executor"
require_relative "wrappers"
require_relative "basics"
require_relative "dsl"

module Marathon
  class Runner
    extend DSL
    include Wrappers
    include Basics

    %w( setup check clean test start ).each do |phase|
      define_method(phase) do
        warn "=== Implement a #{phase} strategy ==="
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
      say "Available commands: #{available_commands.join(', ')}"
    end

    def main(arguments)
      command = arguments[0] || 'all'
      raise Marathon::Error.new("No such command #{command}") unless respond_to?(command)
      if arguments.length > 1
        subcommand_arguments = arguments[1..-1]
        send(command, subcommand_arguments.join(' ').chomp)
      else
        send(command)
      end
    end

    protected

    def available_commands
      boring_commands = [
        :available_commands,
        :main, :dispatch, :run,
        :say, :warn, :ok, :echo,
        :rails, :jest, :rspec, :rake, :yarn, :bundle,
        :all, :help
      ]
      available = self.methods - Object.new.methods - boring_commands
      available.sort
    end

    def dispatch(command='echo "(hello from marathon)"')
      executor.shell command.to_s
    end
    alias :run :dispatch

    private

    def executor
      @executor ||= Executor.new
    end

  end
end
