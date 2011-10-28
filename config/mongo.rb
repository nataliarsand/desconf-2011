require 'mongoid'

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

