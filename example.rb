require 'lib/hydna'

begin
  # sending messages
  Hydna.push("http://public.hydna.net/4001", "Hello World")
  
  # sending signals
  Hydna.emit("http://public.hydna.net/4001", "Hello World")
  
rescue Exception => e
  puts e.message
end