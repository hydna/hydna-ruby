require 'hydna'

# sending messages
Hydna.push("http://public.hydna.net/1", "Hello World")
  
# sending signals
Hydna.emit("http://public.hydna.net/1", "Hello World")
