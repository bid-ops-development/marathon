require_relative 'extends/string'
module Marathon
  module Basics
    def echo(message='hello')
      puts message
    end

    def say(message='hello marathon')
      echo message
    end

    def warn(message='warning!')
      echo "[warning] #{message}".red
    end

    def ok(message='all good')
      echo "[ok] #{message}".green
    end
  end
end
