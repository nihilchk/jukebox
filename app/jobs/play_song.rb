class PlaySong
  @queue = 'jukebox'

  def self.perform(song_id)
  	song = SongRequest.find(song_id)
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
end
