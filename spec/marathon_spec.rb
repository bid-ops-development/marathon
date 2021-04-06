# frozen_string_literal: true
require 'marathon'

RSpec.describe Marathon do
  describe 'run' do
    subject(:result) { Marathon.run command }
    context 'true' do
      let(:command) { :true }
      it { expect(result).to be_successful }
    end
    context 'false' do
      let(:command) { :false }
      it { expect(result).not_to be_successful }
    end
  end
  
  describe Marathon::Result do
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
      expect(Kernel).to receive(:system).with("bash -c \"echo 'hello world'\"")
      executor.shell "echo 'hello world'"
    end

    describe 'shell' do
      describe 'invoking bash driver' do
        it 'returns wrapped result' do
          result = subject.shell "echo 'hello world'", capture_output: true
          expect(result).to be_successful
          expect(result.output).to eq 'hello world'
        end

        it 'returns wrapped error' do
          result = subject.shell "false"
          expect(result).not_to be_successful
        end
      end
    end
  end

  describe 'task runner' do
    subject(:run) do
      Marathon::Runner.new
    end

    let(:executor) { double Marathon::Executor }

    before { allow(subject).to receive(:executor).and_return(executor) }

    describe 'main' do
      it 'relays first arg to subcommand and remaining args as a string' do
        expect(executor).to receive(:shell).with("bundle exec rspec --fail-fast")
        run.main ["rspec", "--fail-fast"]
      end

      it 'relays to shell command' do
        expect(executor).to receive(:shell).with("bundle exec rspec --fail-fast")
        run.main ["rspec", "--fail-fast"]
      end
    end

    describe 'common wrappers' do
      describe 'js' do
        it 'yarn' do
          expect(executor).to receive(:shell).with("yarn install")
          run.yarn 'install'
        end

        it 'jest' do
          expect(executor).to receive(:shell).with("yarn run jest --coverage")
          run.jest '--coverage'
        end
      end

      describe 'ruby' do
        it 'bundler' do
          expect(executor).to receive(:shell).with("bundle install")
          run.bundle :install
        end

        it 'rspec' do
          expect(executor).to receive(:shell).with("bundle exec rspec --fail-fast")
          run.rspec '--fail-fast'
        end

        it 'rake' do
          expect(executor).to receive(:shell).with("bundle exec rake some:task")
          run.rake 'some:task'
        end

        it 'rails' do
          expect(executor).to receive(:shell).with("bundle exec rails some:task")
          run.rails 'some:task'
        end

        it 'rubocop' do
          expect(executor).to receive(:shell).with("bundle exec rubocop -a")
          run.cop '-a'
        end

        it 'guard' do
          expect(executor).to receive(:shell).with("bundle exec guard init")
          run.guard 'init'

          # don't like the extra space here :/
          expect(executor).to receive(:shell).with("bundle exec guard ")
          run.guard
        end
      end
    end
  end
end
