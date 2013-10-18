require 'hydna'

# gem install hydna

# sending messages
Hydna.push("http://public.hydna.net/cli-test", "Hello World from ruby")
  
# sending signals
Hydna.emit("http://public.hydna.net/cli-test", "Hello World from ruby")
