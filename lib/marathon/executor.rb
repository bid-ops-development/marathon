# frozen_string_literal: true

require_relative "bash_driver"

module Marathon
  class Executor
    include BashDriver
  end
end
