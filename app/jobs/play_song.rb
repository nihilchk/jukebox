class PlaySong
  @queue = 'jukebox'

  def self.get_song_detail song_id
    SongRequest.find(song_id)
  end

  def self.perform(song_id)
    song = get_song_detail song_id
		%x{say "This dedication has been made by #{song.requestor} towards #{song.dedicated_to}. Enjoy!"}
  	song.status = "Playing"
    song.save!
    %x{afplay songs/#{song.file_id}.mp3} 
    song.status = "Played"
    song.save!
  end
end

class PlaySongPlayer < PlaySong
  @queue = 'jukebox_player'

  def self.get_song_detail song_id
    object = JSON.parse(Net::HTTP.get(URI.parse("http://jukebox.local:3000/song_requests/#{song_id}.json")))
    SongRequest.new(object)
  end
end
