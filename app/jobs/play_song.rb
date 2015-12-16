class PlaySong
  @queue = :playing

  def self.perform(song_id)
  	song = SongRequest.find(song_id)
  	if song.status == 'Downloaded'
	  	song.status = "Playing"
	    song.save!
	    %x{afplay songs/#{song.file_id}.mp3} 
	end
    song.status = "Played"
    song.save!
  end
end
