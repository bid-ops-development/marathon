# frozen_string_literal: true

require "marathon"

RSpec.describe Marathon do
  describe "run" do
    subject(:result) { Marathon.run command }
    context "true" do
      let(:command) { true }
      it { expect(result).to be_successful }
    end
    context "false" do
      let(:command) { false }
      it { expect(result).not_to be_successful }
    end
  end
end
