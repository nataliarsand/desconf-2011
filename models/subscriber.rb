class Subscriber
  include Mongoid::Document
  field :email => String
  field :name => String
  field :created_at => DateTime
end

