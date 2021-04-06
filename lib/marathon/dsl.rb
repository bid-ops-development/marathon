# frozen_string_literal: true

module Marathon
  # Provide class-level helpers for Runner
  module DSL
    # wrap a simple command directly
    def uses(*tools)
      tools.each do |tool|
        define_method(tool) do |command|
          tool_command = "#{tool} #{command}"
          run tool_command.chomp
        end
      end
    end
  end
end
