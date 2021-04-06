# frozen_string_literal: true

require "marathon"

RSpec.describe Marathon do
  describe "run" do
    # subject(:result) { Marathon.run command }
    context "true" do
      let(:command) { true }
      it 'returns successfully' do
        result = Marathon.run command
        expect(result).to be_successful
      end
    end

    context "false" do
      let(:command) { false }
      it 'throws an error' do
        expect { Marathon.run command }.to raise_error(Marathon::Error)
      end
      # it { expect(result).not_to be_successful }
    end
  end
end
