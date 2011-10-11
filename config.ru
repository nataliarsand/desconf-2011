require 'rubygems'
require 'digest/md5'
require 'compass'
require 'sinatra'
require 'sass'
require 'slim'
require 'mongoid'
require "./basics"


uri = "mongodb://localhost"
dbname = "desconf2011"

if ENV["MONGOHQ_URL"].present?
  uri = ENV["MONGOHQ_URL"]
  dbname = URI.parse(ENV["MONGOHQ_URL"]).path.gsub(/^\//, '')
end

CONN = Mongo::Connection.from_uri(uri)
DB = CONN.db(dbname)

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
