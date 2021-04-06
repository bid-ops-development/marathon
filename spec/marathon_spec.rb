# frozen_string_literal: true

require "marathon"

RSpec.describe Marathon do
  describe "run" do
    context "true" do
      let(:command) { true }
      it "returns successfully" do
        result = Marathon.run command
        expect(result).to be_a(Marathon::Result)
      end
    end

    context "false" do
      let(:command) { false }
      it "throws an error" do
        expect { Marathon.run command }.to raise_error(SystemExit, "Failed to execute false")
      end
    end
  end
end
