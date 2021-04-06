module Marathon
  module Wrappers
    def self.included(klass)
      klass.uses :yarn, :bundle
    end

    # ruby
    RUBY_TOOLS = %w( rspec rake rails guard rubocop )
    RUBY_TOOLS.each do |ruby_tool|
      define_method(ruby_tool) do |command=''|
        bundle "exec #{ruby_tool} #{command}"
      end
    end

    alias :cop :rubocop
    
    # js

    def jest(command='')
      yarn "run jest #{command}"
    end
  end
end
