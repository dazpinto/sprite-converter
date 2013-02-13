def execute(command)
  sh command
  #puts command
end

def ask(message, default="")
  message = "#{message} (#{default})" unless default == ""

  print message
  print "\n"

  result = STDIN.gets.chomp

  if result == "" && default != ""
    default
  else
    result
  end
end