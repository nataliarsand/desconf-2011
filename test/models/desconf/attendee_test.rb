require './test/teststrap'
require './models/desconf_attendee'

context Desconf::Attendee do
  context 'validations' do
    denies_topic.validates_with(:avatar_url,  'not_valid_url')
    asserts_topic.validates_with(:avatar_url, 'http://mydomain.com/naked_me.png')
    asserts_topic.validates_with(:avatar_url, '')
  end
end
