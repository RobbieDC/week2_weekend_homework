require_relative("./room")
require_relative("./guest")
require_relative("./song")

class KaraboabieRunner
  def initialize( room_list, song_list )
    @room_list = room_list
    @song_list = song_list
  end

  def run_karaboabie
    puts "\n--------------------------------------------------------------------------------"
    puts "Welcome to KaraBoabie! Ready to get down to some of the hottest beats like \"Row Row Row Your Boat\" and \"Twinkle Twinkly Little Star\"?"
    puts "\nHow many are in your party?"
    num_guests = gets.chomp.to_i

    available_rooms = []
    for room in @room_list
      available_rooms.push(room) if room.can_hold_party(num_guests)
    end
      
    if available_rooms.count == 0
      puts "\nUnfortunately your party is too large for any of our rooms... Goodbye"
      abort
    end
    
    puts "\nWe currently have space for your party in:"
    room_selector = 0
    
    for room in available_rooms
      puts " - #{room.theme}"
    end
    puts "\nWhich room would you like to use?"
    user_selected_room = gets.chomp
    case user_selected_room.downcase
      when "hot beatz"
        selected_room = @room_list[0]
        puts "Good choice! Hope you're ready for some #{@room_list[0].theme}"
      when "hotter beatz"
        selected_room = @room_list[1]
        puts "Good choice! Hope you're ready for even #{@room_list[1].theme}"
      when "hottest beatz"
        selected_room = @room_list[2]
        puts "Good choice! Hope you're ready for the #{@room_list[2].theme}"
    end

    handle_arriving_guests(num_guests, selected_room)

    user_menu(selected_room)

  end

  def user_menu(selected_room)
    puts "\nEnter 1 to choose songs"
    puts "Enter 2 to leave"
    choice = gets.chomp.to_i

    case choice
      when 1
        add_songs(selected_room)
      when 2
        leave(selected_room)
    end 
  end

  def handle_arriving_guests(num_guests, selected_room)
    count = 1
    while count <= num_guests do
      puts "\nHi guest #{count}, please provide your details"
      puts " - Name:"
      guest_name = gets.chomp
      puts " - How much you'd like to spend:"
      guest_cash = gets.chomp
      puts "Hi #{guest_name}, you have £#{guest_cash}"
      guest = Guest.new(guest_name, guest_cash)
      selected_room.check_in_guest(guest)
      count += 1
    end

  def add_songs(selected_room)
    puts "\nWe have the following songs:"
    song_num = 0
    for song in @song_list
      song_num += 1
      puts " - #{song_num}. #{song.title}, by #{song.artist}"
    end
    puts "Enter 1 or 2 to select your song!"
    selected_song = gets.chomp.to_i
    row_boat = @song_list[0]
    twinkle_twinkle = @song_list[1]
    if selected_song == 1
      selected_room.add_song(row_boat)
      user_song = row_boat
    elsif selected_song == 2
      selected_room.add_song(twinkle_twinkle)
      user_song = twinkle_twinkle
    end
    puts "Great choice! Enjoy your time at KaraBoabie singing #{user_song.title} in #{selected_room.theme}!"
    user_menu(selected_room)
  end

  def leave(selected_room)
    guest_list = selected_room.guest
    for guest in guest_list
      puts "\nAre you sure you want to leave, #{guest.name}? (y/n)"
      response = gets.chomp
      if response == "y"
        selected_room.check_out_guest(guest)
        puts "Hope you had fun. May the Hot Beatz stay with you!"
      elsif response == "n"
        puts "Glad to hear it! Keep rocking to them hot beatz!"
      end
    end
  end

  end

end


hot_beatz = Room.new("Hot Beatz", 5, 10, 3, [])
hotter_beatz = Room.new("Hotter Beatz", 10, 20, 2, [])
hottest_beatz = Room.new("Hottest Beatz", 15, 30, 1, [])
room_list = [hot_beatz, hotter_beatz, hottest_beatz]

song_a = Song.new("Row Your Boat", "The Boat Men", 5)
song_b = Song.new("Tinkle Twinkle", "Twinkly McStarface", 4)
song_list = [song_a, song_b]

runner = KaraboabieRunner.new(room_list, song_list)
runner.run_karaboabie()