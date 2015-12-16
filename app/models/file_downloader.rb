class FileDownloader
  def self.enqueue_download song_url, song_request
    Thread.new do
      %x{mkdir -p songs && cd songs && youtube-dl --id -x --audio-format mp3 #{song_url}}
      if File.exist? "songs/#{song_request.file_id}.mp3"
        song_request.status = 'Downloaded'
        Resque.enqueue(PlaySong, song_request.id)
      else
        song_request.status = 'Error'
      end
      song_request.save!
    end.run
  end
end