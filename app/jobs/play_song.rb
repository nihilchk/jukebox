class PlaySong
  @queue = Jukebox::Application.config.master_server_config['servername']

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
  def self.get_song_detail song_id
    url = "http://#{Jukebox::Application.config.master_server_config['servername']}:3000/song_requests/#{song_id}.json"
    object = JSON.parse(Net::HTTP.get(URI.parse(url)))
    OpenStruct.new(object)
  end
end
