module BashDriver
  def shell(command, capture_output: false)
    success = false
    output = ''
    bash_command = "bash -c \"#{command}\""

    if capture_output
      output = `#{command}`
      success = $?.exitstatus.zero?
    else
      success = Kernel.system command
    end

    Marathon::Result.new(
      successful: success,
      output: output.chomp
    )
  end
end
