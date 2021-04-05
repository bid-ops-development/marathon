# frozen_string_literal: true
require 'marathon'

RSpec.describe Marathon do
  it "has a version number" do
    expect(Marathon::VERSION).not_to be nil
  end

  describe 'result' do
    subject(:result) do
      Marathon::Result.new(
        output: 'hello world',
        successful: true
      )
    end

    it "is successful" do
      expect(result).to be_successful
    end

    it "has output" do
      expect(result.output).to eq 'hello world'
    end
  end

  describe 'executor' do
    subject(:executor) do
      Marathon::Executor.new
    end
    
    it "can relay a successful command" do
      expect(subject).to receive(:system!).with("echo 'hello world'")
      subject.execute "echo 'hello world'"
    end

    describe 'system!' do
      # system calls shell, which wraps bash
      it 'calls out to shell' do
        expect(subject).to receive(:shell).with("echo 'hello world'")
        subject.system! "echo 'hello world'"
      end
    end

    describe 'shell' do
      describe 'invoking bash driver' do
        it 'returns wrapped result' do
          result = subject.shell "echo 'hello world'"
          expect(result).to be_successful
          expect(result.output).to eq 'hello world'
        end

        it 'returns wrapped error' do
          result = subject.shell "false"
          expect(result).not_to be_successful
          # expect(result.output).to eq 'hello world'
        end
      end
    end
  end
end
