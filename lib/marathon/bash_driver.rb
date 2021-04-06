module BashDriver
  def shell(command, capture_output: false)
    output, success = execute_bash!(command, capture_output)
    return result(success, output)
  end

  private

  def execute_bash!(command, capture = false)
    success = false
    output = ''
    # bash_command = "bash -c \"#{command}\""
    return ['', Kernel.system(bash command)] unless capture
    [`#{bash command}`, $?.exitstatus.zero?]
  end

  def bash(command)
    "bash -c \"#{command}\""
  end

  def result(success, output)
    Marathon::Result.new(
      successful: success,
      output: output.chomp
    )
  end
end
