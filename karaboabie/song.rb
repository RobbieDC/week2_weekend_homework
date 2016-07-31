class Song

  attr_reader :title, :artist, :length
  def initialize(title, artist, length)
    @title = title
    @artist = artist
    @length = length
  end

end