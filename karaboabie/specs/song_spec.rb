require("minitest/autorun")
require_relative("../song")

class TestSong < MiniTest::Test

  def setup
    @song_a = Song.new("Row Your Boat", "The Boat Men", 5)
  end

  def test_song_title
    assert_equal("Row Your Boat", @song_a.title)
  end

end