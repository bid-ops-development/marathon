module Marathon
  module Wrappers
    class << self
      # wrap a simple command directly
      def uses(*tools)
        tools.each do |tool|
          define_method(tool) do |command|
            run "#{tool} #{command}"
          end
        end
      end
    end

    uses :yarn, :bundle
    def rspec(command='')
      bundle "exec rspec #{command}"
    end

    def jest(command='')
      yarn "run jest #{command}"
    end
  end
end
