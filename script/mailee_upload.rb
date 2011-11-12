require './config/mongo'
require './config/slim'
require './models/subscriber'
require './lib/mailee'


def subscribers_emails
  Subscriber.all.map do |s|
    unless s.email =~ /@/
      "#{s.name}@#{s.email}"
    else
      s.email
    end
  end
end

def ensure_list_exists(list_name)
  list = Mailee::List.find(:first, params: {name: list_name})
  if list.nil?
    list = Mailee::List.create(name: list_name)
  end
end

ensure_list_exists "desconf-2010"
ensure_list_exists "desconf-2011"

subscribers_emails.each do |email|
  contact = Mailee::Contact.find(:first, params: {email: email})

  if contact.nil?
    puts "Creating #{email}"
    contact = Mailee::Contact.create(email: email)
  else
    puts "Using #{email}"
    puts "Subscribing #{email} to desconf-2010"
    contact.put(:subscribe, list: "desconf-2010")
  end

  puts "Subscribing #{email} to desconf-2011"
  contact.put(:subscribe, list: "desconf-2011")
end
