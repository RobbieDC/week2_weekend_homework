require("minitest/autorun")
require_relative("../room")
require_relative("../guest")
require_relative("../song")

class TestRoom < MiniTest::Test

  def setup
    @room_a = Room.new( "J Pop", 20, 60, 2)
    @guest_a = Guest.new("Rowan", 200)
    @song_a = Song.new("Twinkle Twinkle", "Twinkly McStarface", 4)
  end

  def test_room_theme
    assert_equal("J Pop", @room_a.theme)
  end

  def test_room_cost
    assert_equal(20, @room_a.cost)
  end

  def test_room_time_limit
    assert_equal(60, @room_a.time_limit)
  end

  def test_capacity
    assert_equal(2, @room_a.capacity)
  end

  def test_can_hold_party
    party_fits = @room_a.can_hold_party(3)
    assert_equal(false, party_fits)
  end

  def test_decrease_time
    @room_a.decrease_time(20)
    assert_equal(40, @room_a.time_limit)
  end

  def test_check_in_guest
    @room_a.check_in_guest(@guest_a)
    checked_in_guest = @room_a.guest[0]
    assert_equal(@guest_a, checked_in_guest)
    assert_equal(200, checked_in_guest.cash)
    assert_equal("Rowan", checked_in_guest.name)
  end

  def test_check_out_guest
    @room_a.check_in_guest(@guest_a)
    @room_a.check_out_guest(@guest_a)
    assert_equal([], @room_a.guest)
  end

  def test_occupancy__with_guest
    @room_a.check_in_guest(@guest_a)
    assert_equal(1, @room_a.occupied)
  end

  def test_occupancy__without_guest
    assert_equal(0, @room_a.occupied)
  end

  def test_add_song
    @room_a.add_song(@song_a)
    playlist_song = @room_a.playlist[0]
    assert_equal(@song_a, playlist_song)
    assert_equal("Twinkle Twinkle", playlist_song.title)
    assert_equal("Twinkly McStarface", playlist_song.artist)
    assert_equal(4, playlist_song.length)
  end

end