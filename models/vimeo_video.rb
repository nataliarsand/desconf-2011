class VimeoVideo
  attr_accessor :id, :title, :thumbnail

  def embed_code
    <<-CODE
      <iframe 
        src="http://player.vimeo.com/video/#{id}?title=0&amp;byline=0&amp;portrait=0" 
        width="400" 
        height="225" 
        frameborder="0" 
        webkitAllowFullScreen allowFullScreen>
      </iframe>
      <p>
        <a href="http://vimeo.com/#{id}">
          #{title}
        </a> 
      </p>
    CODE
  end
end
