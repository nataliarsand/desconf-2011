require './config/mongo'
require './models/pagseguro_transaction_history'
require './models/desconf_ticket_transaction'

history = Pagseguro::TransactionHistory.last_30_days email: ENV['PAGSEGURO_EMAIL'], token: ENV['PAGSEGURO_TOKEN']
history.transactions.each do |t| 
  if Desconf::TicketTransaction.load_from_transaction(t) 
    puts "* loaded #{t.status} transaction from \"#{t.customer.email}\"" 
  else
    puts "! error loading transaction from \"#{t.customer.email}\""
  end
end
