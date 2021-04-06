# frozen_string_literal: true

require "spec_helper"
require "support/verify_wrappers"

RSpec.describe Marathon::Runner do
  subject(:run) do
    described_class.new
  end
  let(:executor) { double Marathon::Executor }
  before { allow(subject).to receive(:executor).and_return(executor) }

  describe "main" do
    it "relays first arg to subcommand and remaining args as a string" do
      expect(executor).to receive(:shell).with("bundle exec rspec --fail-fast")
      run.main ["rspec", "--fail-fast"]
    end

    it "relays to shell command" do
      expect(executor).to receive(:shell).with("bundle exec rspec --fail-fast")
      run.main ["rspec", "--fail-fast"]
    end
  end

  verify_wrappers!
end
