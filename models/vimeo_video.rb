class VimeoVideo
  include Mongoid::Document
  field :vimeo_id => String
  field :title    => String
  field :thumnail => String

  def embed_code
    <<-CODE
      <iframe 
        src="http://player.vimeo.com/video/#{vimeo_id}?title=0&amp;byline=0&amp;portrait=0" 
        width="400" 
        height="225" 
        frameborder="0" 
        webkitAllowFullScreen allowFullScreen>
      </iframe>
      <p>
        <a href="http://vimeo.com/#{vimeo_id}">
          #{title}
        </a> 
      </p>
    CODE
  end

  def self.from_json(json)
    new({
      :vimeo_id  => json['id'],
      :title     => json['title'],
      :thumbnail => json['thumbnail_medium'],
    })
  end
end
