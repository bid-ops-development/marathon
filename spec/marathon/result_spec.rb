# frozen_string_literal: true

require "spec_helper"

RSpec.describe Marathon::Result do
  subject(:result) do
    Marathon::Result.new(output: "hello world")
  end

  it "has output" do
    expect(result.output).to eq "hello world"
  end
end
