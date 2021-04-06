# Marathon

Welcome to Marathon!

## Synopsis

Marathon is a tool to help you quickly create task runners for your application. 

It is focused on building commands up compositionally, with a DSL to help simplify and document important commands for your application and their usage.

## Usage

**Start with a tiny `run` script.** Create a new file at `bin/run`:

```
#!/usr/bin/env ruby

require 'bundler/inline'
gemfile do
  gem 'marathon', git: 'https://github.com/bid-ops-development/marathon'
end

class MyCustomRunner < Marathon::Runner
  def test
    run "bundle exec rake test:everything"
  end
end

if __FILE__ == $0
  runner = MyCustomRunner.new
  runner.main(ARGV)
end
```

You should now be able to `bin/run test` and see Marathon execute RSpec. (Note: you may need to `chmod +x bin/run` to turn execute permissions on.)

**Let's simplify!** Some of the common tooling is wrapped, so the `test` strategy can be written like:

```
  def test
    bundle "exec rake test:everything"
  end
```

However, `rake` itself has a wrapper -- so that we could finally write something here like `rake "test:everything"`:

```
  def test
    rake "test:everything"
  end
```

**Some more tips.**

1. Commands are intended to be compositional (e.g. `rake` invokes `bundle`).
2. `all` is the default argument given to a 'bare command' invocation of the base runner, so consider using it as a default argument. For instance when deciding which test suite to execute you might write:

```
  def test(suite='all')
    raise "No such test suite #{suite}" unless %w( all ruby js ).include?(suite)
    rspec if suite == 'all' || suite == 'ruby'
    jest if suite == 'all' || suite == 'js'
    say "Tests passed (#{suite})"
  end
```

3. Some common flows are defined but can be over-ridden:
  - `verify` calls `clean`, `check` and finally `test`
  - `all` (the bare command) calls `verify` and then `start`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
