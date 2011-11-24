require 'rubygems'
require 'riot'
require 'ruby-debug'

Dir.glob('./{config,test/support}/*.rb').each {|f| 
  puts "Loaded #{f}" if require f 
}
