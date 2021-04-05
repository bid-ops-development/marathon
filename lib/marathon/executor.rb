module BashDriver
  def bash(command)
    output = `bash -c \"#{command}\"`
    successful = $?.exitstatus.zero?
    result = Marathon::Result.new(
      successful: successful,
      output: output.chomp
    )

    result
  end

  alias :shell :bash
end

class Marathon::Executor
  include BashDriver

  def execute(command)
    puts "[Marathon] Executing #{command}"
    self.system!(command)
  end

  def system!(command)
    shell command
  end
end
