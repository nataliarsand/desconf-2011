module Desconf
  class Attendee
    include Mongoid::Document

    field :name            , type: String
    field :email           , type: String
    field :type            , type: String
    field :transaction_code, type: String

    def self.load_from_ticket(ticket)
      new.tap do |attendee|
        attendee.name  = ticket.buyer_name
        attendee.email = ticket.buyer_email
        attendee.type  = ticket.ticket_type
        attendee.transaction_code = ticket.transaction_code
      end
    end
  end
end
