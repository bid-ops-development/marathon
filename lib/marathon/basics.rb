# TODO move to extends/string
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end
  def red; colorize(31) end
  def green; colorize(32) end
end

module Marathon
  module Basics
    def echo(message='hello')
      run "echo \"#{message}\""
    end

    def say(message='hello marathon')
      echo message
    end

    def warn(message='warning!')
      echo message.red
    end

    def ok(message='all good')
      echo message.green
    end
  end
end
