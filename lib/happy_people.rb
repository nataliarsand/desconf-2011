module Desconf
  module HappyPeople
    def happy_people!
      emails = {
        barbara: "barbara@quavio.com.br",
        daniel: "dwildt@gmail.com",
        felipe: "felipe.benites@gmail.com",
        natalia: "nataliarsand@gmail.com",
        pedro: "pedrobelleza@gmail.com",
        rafael: "rafaelbandeira3@gmail.com",
        mauricio: "m@bitbonsai.com"
      }.each_pair { |k, v| v.replace(Digest::MD5.hexdigest(v)) }

      gravatar = lambda { |name| "http://www.gravatar.com/avatar/#{emails[name]}" }

      people = [
        {
          href: "http://twitter.com/barbaracones",
          name: "Barbara Wolff Dick",
          gravatar: gravatar[:barbara]
        },
        {
          href: "http://twitter.com/dwildt",
          name: "Daniel Wildt",
          gravatar: gravatar[:daniel]
        },
        {
          href: "http://twitter.com/felipebcabral",
          name: "Felipe Cabral",
          gravatar: gravatar[:felipe]
        },
        {
          href: "http://twitter.com/nataliarsand",
          name: "Natalia Arsand",
          gravatar: gravatar[:natalia]
        },
        {
          href: "http://twitter.com/bitbonsai",
          name: "Mauricio Wolff",
          gravatar: gravatar[:mauricio]
        },
        {
          href: "http://twitter.com/pedrobelleza",
          name: "Pedro Belleza",
          gravatar: gravatar[:pedro]
        },
        {
          href: "http://twitter.com/rafb3",
          name: "Rafael Bandeira",
          gravatar: gravatar[:rafael]
        }
      ]
    end
  end
end
