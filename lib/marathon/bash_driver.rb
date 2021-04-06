# frozen_string_literal: true

require "English"

# A driver that implements #shell as local bash execute.
# (The idea is to abstract how we actually execute a shell command
# so that in theory we could do it differently, ie on a remote system
# or in a container.)
module BashDriver
  def shell(command, capture_output: true)
    output, success = execute_bash!(command, capture: capture_output)
    result(success, output)
  end

  private

  def execute_bash!(command, capture:)
    return ["", Kernel.system(bash(command))] unless capture

    [`#{bash command}`, $CHILD_STATUS.exitstatus.zero?]
  end

  def bash(command)
    "bash -c \"#{command}\""
  end

  def result(success, output)
    Marathon::Result.new(
      successful: success,
      output: output.chomp
    )
  end
end
