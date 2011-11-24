require 'rubygems'
require 'riot'
require 'ruby-debug'

Dir.glob('./config/*.rb').each {|f| 
  puts "Loaded #{f}" if require f 
}
