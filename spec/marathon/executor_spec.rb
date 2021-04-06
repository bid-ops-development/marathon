# frozen_string_literal: true

require "spec_helper"

RSpec.describe Marathon::Executor do
  subject(:executor) do
    described_class.new
  end

  it "can relay a successful command" do
    expect(Kernel).to receive(:system).with("bash -c \"echo 'hello world'\"")
    executor.shell "echo 'hello world'"
  end

  describe "shell" do
    describe "invoking bash driver" do
      it "returns wrapped result" do
        result = subject.shell "echo 'hello world'", capture_output: true
        expect(result).to be_successful
        expect(result.output).to eq "hello world"
      end

      it "returns wrapped error" do
        result = subject.shell "false"
        expect(result).not_to be_successful
      end
    end
  end
end
