require 'lib/hydna'

begin
  # sending messages
  Hydna.push("https://public.hydna.net/4001", "Hello World åäö")
  
  # sending signals
  #Hydna.emit("https://public.hydna.net/4001", "Hello World")
  
rescue Exception => e
  puts e.message
end