# Marathon

Welcome to Marathon!

## Synopsis

Marathon is a tool to help you quickly create task runners for your application. 

It is focused on building commands up compositionally, with a DSL to help simplify and document important commands for your application and their usage.

## Usage

**First, install Marathon.** For this example add it to your Gemfile and run `bundle install`.

**Now start with a tiny `run` script.** Create a new file at `bin/run`:

```
#!/usr/bin/env ruby

require 'bundler/setup'
require 'marathon'

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

However, in this case, there is even a wrapper for `rake` -- so that we could finally write `rake "test:everything"`:

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

## Motivation

### How should I use this?

Ideal usage here is as a command builder sort of pattern, building up the description of how to invoke common tooling and then instrumenting it by incorporating it into a very flexible work flow manager.

It should be easy for most devs to extend compositionally -- Ruby seems more appropriate than bash and more accessible than make for this purpose. A major goal of this project is to make it _easy_ to produce executable documentation of the build processes for your project.

### Why not rake? or make?

A few key points here. `marathon` is focused on run scripts for web applications in Ruby and maybe some light Javascript orchestration. It's not trying to target "development process in general" although hopefully it's reasonably flexible for that end.

In particular `marathon` doesn't care about running things in any sort of particular order other than one literally specified (e.g., analyzing dependencies between tasks is out of scope). It is therefore mostly interested in acting like a script (and supporting script-like command sequences).

### Okay, so why not bash?

Bash is great! Honestly this is an evolution of a run script practice that originates in tiny bash scripts (and trying to apply that in a Ruby-centric development environment).
Using `marathon` might feel a little bit like you're writing a set of bash runner functions but from within a ruby shell.
One idea is to keep the spirit of a tiny headless bash runner that can drive project tasks... _without_ having to resort to something as strongly-opinionated as rake/make/etc.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
