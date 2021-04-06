# frozen_string_literal: true

require "open3"

require "English"

module Marathon
  # The default driver that implements #shell as local bash command execution (wrapped with `bash -c`).
  class BashDriver
    def run(command, capture_output: true)
      puts "[Marathon::BashDriver] #{command}"
      output, success = execute_bash! command
      puts output unless capture_output
      return build_result(output) if success

      puts output
      # error = "=== Failed to execute: #{command} ==="
      # warn error
      abort "Failed to execute #{command}"
    end

    private

    def execute_bash!(command)
      cmd = bash command
      stdout, _stderr, status = Open3.capture3(cmd)
      [stdout, status.exitstatus.zero?]
    end

    def bash(command)
      "bash -c \"#{command}\""
    end

    def build_result(output)
      Marathon::Result.new(output: output.chomp)
    end
  end
end
