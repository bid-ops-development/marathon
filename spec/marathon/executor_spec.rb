# frozen_string_literal: true

require "spec_helper"

RSpec.describe Marathon::Executor do
  subject(:executor) do
    described_class.new
  end

  it "can relay a successful command" do
    status = double Process::Status, exitstatus: 0
    expect(Open3).to receive(:capture2e).with("bash -c \"true\"").and_return(["", status])
    executor.shell "true"
  end

  describe "shell" do
    describe "invoking bash driver" do
      it "returns wrapped result" do
        result = subject.shell "echo 'hello world'", capture_output: true
        expect(result.output).to eq "hello world"
      end

      it "returns wrapped error" do
        expect do
          subject.shell false
        end.to raise_error(SystemExit, "Failed to execute false")
      end
    end
  end
end
