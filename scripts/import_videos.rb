#! /usr/bin/env ruby

require "./config/mongo"
require "./models/vimeo_album"

DESCONF2010_VIMEO_ALBUM = "1498296"

puts "* Starting download of #desconf 2010 videos"
album = VimeoAlbum.find(DESCONF2010_VIMEO_ALBUM)
puts "* Download finished successfuly!"
puts "* Starting saving videos data"
album.videos.each do |v|
  v.save!
  puts "** Saved #{v[:title]}"
end
puts "* Finished importing videos!"
