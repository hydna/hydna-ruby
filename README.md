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
	  Hydna.push("https://public.hydna.net/4000", "Hello World")

	  # sending signals
	  Hydna.emit("https://public.hydna.net/4000", "Hello World") 

	rescue Exception => e
	  puts e.message
	end