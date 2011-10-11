require 'rubygems'
require 'digest/md5'
require 'compass'
require 'sinatra'
require 'sass'
require 'slim'
require 'mongoid'
require "./basics"

CONN = Mongo::Connection.new(ENV["MONGOHQ_URL"] || "localhost")
DB = CONN.db("desconf2011")

Mongoid.configure do |c|
  c.master = DB
end

class Subscriber
  include Mongoid::Document
  field :email => String
  field :name => String
  field :created_at => DateTime
end
run MyApp
