module Desconf
  class Attendee
    include Mongoid::Document

    field :name            , type: String
    field :email           , type: String
    field :type            , type: String
    field :avatar_url      , type: String
    field :transaction_code, type: String
    field :twitter_handle  , type: String
    field :website_url     , type: String
    field :tags            , type: String
    field :pizza_flavors   , type: String
    field :vegan           , type: Boolean
    field :is_foda         , type: Boolean

    validates_presence_of :is_foda, message: "Corrija o campo 'Sou foda?'"
    validates_format_of :avatar_url, with: /^https?:\/\/.+$/

    def self.load_from_ticket(ticket)
      obj = where(:transaction_code => ticket.transaction_code).first
      return obj unless obj.nil?

      new.tap do |attendee|
        attendee.name   = ticket.buyer_name
        attendee.email = ticket.buyer_email
        attendee.type  = ticket.ticket_type
        attendee.transaction_code = ticket.transaction_code
      end
    end

    def avatar
      return avatar_url unless avatar_url.blank?
      gravatar
    end

    protected
    def gravatar
      require 'digest/md5'
      hash = Digest::MD5.hexdigest(email)
      "http://www.gravatar.com/avatar/#{hash}"
    end
  end
end
