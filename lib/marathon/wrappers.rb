module Marathon
  module Wrappers
    def self.included(klass)
      klass.uses :yarn, :bundle
    end

    def rspec(command='')
      bundle "exec rspec #{command}"
    end

    def rake(command='')
      bundle "exec rake #{command}"
    end

    def rails(command='')
      bundle "exec rails #{command}"
    end

    def jest(command='')
      yarn "run jest #{command}"
    end
  end
end
