# Hydna Ruby Client Library

This first version of our client library for Ruby implements support for the
Hydna Push API. Future versions will include support for the full set of
features.

More info: https://www.hydna.com/

## Installation
	
	gem install hydna

## Usage

The `hydna`-module exposes two functions:

    require 'hydna'

	begin
	  # sending messages
	  Hydna.push("http://public.hydna.net/hello", "Hello World")

	  # sending signals
	  Hydna.emit("http://public.hydna.net/hello", "Hello World") 

	rescue Exception => e
	  puts e.message
	end