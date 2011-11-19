module Desconf
  module HostVerification
    def self.included(obj)
      obj.before do
        redirect "http://desconf.com.br" if heroku_host?
      end
    end

    def heroku_host?
      request.host.match(/heroku/)
    end
  end
end
