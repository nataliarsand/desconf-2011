module Desconf
  module HappyPeople
    def happy_people!
      @happy_people ||= YAML::load(File.read('./config/happy_people.yml'))
    end
  end
end
