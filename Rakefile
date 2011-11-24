require 'rubygems'
require 'rake'
require 'rake/testtask'

desc 'Test the crap out of this app'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test

task :load_ticket_transactions do
  require './scripts/load_ticket_transactions'
end

task :load_attendees => :load_ticket_transactions do
  require './scripts/load_attendees'
end
