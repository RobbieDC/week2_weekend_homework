class Room

  attr_reader :theme, :cost, :time_limit, :capacity, :guest, :playlist, :occupancy
  def initialize(theme, cost, time_limit, capacity, guest=[], playlist=[], occupancy=nil)
    @theme = theme
    @cost = cost
    @time_limit = time_limit
    @capacity = capacity
    @guest = guest
    @playlist = playlist
    @occupancy = occupancy
  end

  def decrease_time(time_passed)
    @time_limit -= time_passed
  end

  def can_hold_party(num_guests)
    num_guests <= @capacity
  end

  def check_in_guest(incoming_guest)
    @guest.push(incoming_guest)
  end

  def check_out_guest(outgoing_guest)
    guest_list = @guest
    guest_list.delete(outgoing_guest)
  end

  def occupied
    @occupancy = @guest.count if @guest
  end

  def add_song(song_to_add)
    @playlist.push(song_to_add)
  end

end