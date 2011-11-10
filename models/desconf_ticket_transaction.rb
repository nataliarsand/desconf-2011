module Desconf
  class TicketTransaction
    include Mongoid::Document

    field :transaction_code , type: String
    field :ticket_type      , type: String
    field :buyer_email      , type: String
    field :buyer_name       , type: String
    field :status           , type: String

    def self.load_from_transaction(transaction)
      code = transaction.code
      obj = where(:transaction_code => code).first
      obj = new if obj.nil?
      obj.transaction_code = code
      obj.buyer_email = transaction.customer.email
      obj.buyer_name = transaction.customer.name
      obj.status = transaction.status.to_s
      obj.ticket_type = transaction.raw.doc.xpath('//items/item[1]/id').text.to_i == 1? 'speaker' : 'listener'
      obj.save
    end
  end
end
