require 'test/unit'
require './models/vimeo_video'

class VimeoVideoTest < Test::Unit::TestCase
  def setup
    @subject = VimeoVideo.new
    @subject.id = '123'
    @subject.title = 'a good video'
  end

  def testEmbedCode
    assert_match @subject.embed_code, %r|iframe|
    assert_match @subject.embed_code, %r|video/123|
    assert_match @subject.embed_code, %r|vimeo.com/123|
    assert_match @subject.embed_code, %r|a good video|
  end
end
