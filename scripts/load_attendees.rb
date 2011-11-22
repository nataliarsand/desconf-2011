require './config/mongo'
require './models/desconf_ticket_transaction'
require './models/desconf_attendee'

include Desconf

tickets = TicketTransaction.all

tickets.select(&:confirmed?).each do |ticket|
  attendee = Attendee.load_from_ticket(ticket)
  attendee.is_foda = true

  if attendee.save
    puts "* loaded #{attendee.email} as #{attendee.type}"
  else
    puts "! failed to load #{attendee.email}: #{attendee.errors.full_messages.join(',')}"
  end
end
