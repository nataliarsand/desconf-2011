require "json"
require "open-uri"
require "./models/vimeo_video"

class VimeoAlbum
  API_URL = "http://vimeo.com/api/v2/album/{id}/videos.json?page={page}"
  attr_accessor :videos

  def initialize
    @videos = []
  end

  def self.find(id)
    page = 0
    album = new

    while(true)
      videos = get(id, page += 1)
      break if videos.nil? or videos.empty?

      album.videos << videos.map do |v|
        VimeoVideo.from_json(v)
      end
    end

    album.videos.flatten!
    album
  end

  def self.get(id, page)
    url = API_URL.gsub(%r|{id}|, id).gsub(%r|{page}|, page.to_s)
    content = open(url).read
    JSON.parse(content) unless content.empty?
  end
end
