require './models/pagseguro_transaction_history'
module Desconf
  class TicketsTransactionHistory < Pagseguro::TransactionHistory
    def initialize
      super(:email => ENV['PAGSEGURO_EMAIL'], :token => ENV['PAGSEGURO_TOKEN'])
    end

    def self.last_30_days
      super(:email => ENV['PAGSEGURO_EMAIL'], :token => ENV['PAGSEGURO_TOKEN'])
    end

    def transactions_collection
      
    end
  end
end
