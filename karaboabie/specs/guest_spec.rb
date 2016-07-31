require("minitest/autorun")
require_relative("../guest")

class TestGuest < MiniTest::Test

  def setup
    @guest_a = Guest.new("Rowan", 200)
  end

  def test_guest_name
    assert_equal("Rowan", @guest_a.name)
  end

  def test_guest_cash
    assert_equal(200, @guest_a.cash)
  end

end