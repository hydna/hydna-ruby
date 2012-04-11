require 'lib/hydna'

begin
  # sending messages
  Hydna.push("https://public.hydna.net/4000", "Hello")
  
  # sending signals
  Hydna.emit("https://public.hydna.net/4000", "Hello") 
  
rescue Exception => e
  puts e.message
end