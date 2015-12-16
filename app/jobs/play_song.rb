class PlaySong
  @queue = :playing

  def self.perform(song_id)
    song = SongRequest.find(song_id)
    %x{afplay songs/#{song.file_id}.mp3} if song.status == 'Downloaded'
    song.status = "Played"
    song.save!
  end
end
