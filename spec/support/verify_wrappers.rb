# frozen_string_literal: true

def expect_shell(command)
  expect(executor).to receive(:shell).with(command)
end

def verify_javascript_wrappers!
  describe "js tooling" do
    it "yarn" do
      expect_shell "yarn install"
      run.yarn "install"
    end

    it "jest" do
      expect_shell("yarn run jest --coverage")
      run.jest "--coverage"
    end
  end
end

def verify_rake!
  it "rake" do
    expect_shell("bundle exec rake some:task")
    run.rake "some:task"
  end
end

def verify_rspec!
  it "rspec" do
    expect_shell("bundle exec rspec --fail-fast")
    run.rspec "--fail-fast"
  end
end

def verify_ruby_basics!
  describe "ruby basics" do
    it "bundler" do
      expect_shell("bundle install")
      run.bundle :install
    end

    verify_rake!
    verify_rspec!
  end
end

def verify_ruby_web!
  describe "ruby web frameworks" do
    it "rails" do
      expect_shell("bundle exec rails some:task")
      run.rails "some:task"
    end
  end
end

def verify_ruby_dev!
  describe "ruby dev flow" do
    it "rubocop" do
      expect_shell("bundle exec rubocop -a")
      run.cop "-a"
    end

    it "guard" do
      expect_shell("bundle exec guard init")
      run.guard "init"
    end
  end
end

def verify_ruby_wrappers!
  verify_ruby_basics!
  verify_ruby_web!
  verify_ruby_dev!
end

def verify_wrappers!
  verify_ruby_wrappers!
  verify_javascript_wrappers!
end
