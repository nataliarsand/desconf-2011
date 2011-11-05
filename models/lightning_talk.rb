require './models/vimeo_video'

class LightningTalk
  attr_accessor :thumbnail, :author, :title, :vimeo_id

  def initialize(vimeo_video)
    @thumbnail = vimeo_video[:thumbnail]
    @author    = vimeo_video[:title].gsub(/.+ por (.+)/, '\1')
    @title     = vimeo_video[:title].gsub(/"([^"]+)".+/, '\1')
    @vimeo_id  = vimeo_video[:vimeo_id] 
  end

  def self.from_desconf_2010
    VimeoVideo.all.map do |v|
      new(v)
    end
  end
end
