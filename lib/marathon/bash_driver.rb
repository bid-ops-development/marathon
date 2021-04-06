# frozen_string_literal: true

require "open3"
require "English"

module Marathon
  # The default driver that implements #shell as local bash command execution
  # (wrapped with `bash -c`).
  class BashDriver
    def run(command, capture_output: false)
      output, success = bash! command
      puts output unless capture_output
      return build_result(output) if success

      puts output
      abort "Failed to execute #{command}"
    end

    private

    def bash!(command)
      stdout, status = Open3.capture2e bash(command)
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
