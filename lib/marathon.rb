# frozen_string_literal: true

require_relative "marathon/version"
require_relative "marathon/executor"

module Marathon
  class Error < StandardError; end
  class Result < Struct.new(:successful, :output, keyword_init: true)
    def successful?; !!self.successful end
  end

  # TODO class Runner; end
end
