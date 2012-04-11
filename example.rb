require 'hydna'

begin
  # sending messages
  Hydna.push("https://public.hydna.net/4001", "Hello World")
  
  # sending signals
  Hydna.emit("https://public.hydna.net/4001", "Hello World") 
  
rescue Exception => e
  puts e.message
end