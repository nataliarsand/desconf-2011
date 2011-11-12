module Desconf
  module Registration
    def registration_open?
      true
    end

    def speaker_code
      variants = %w{9BE5FF902D2D815DD41A6FB3E6D6797F C1B8B60BDBDB37A994A45FA1834F796A 5BB518FA8080A6F774912FBD6E460451 4B56643D1B1B54F2241C6FB96D869205}
      variants[rand(variants.size)]
    end
  end
end
