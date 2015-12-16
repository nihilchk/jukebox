class SongRequest < ActiveRecord::Base
  validates_presence_of :dedicated_to, :song_url, :message, :requestor
  validates_format_of :song_url, :with => /(http|https):\/\/www[.]youtube[.]com\/watch[?]v=.*/ix

  before_create :set_status
  after_create :download_file

  def set_status
    self.status = 'New'
  end

  def file_id
    song_url.split('v=').last.split('&').first
  end

  def download_file
    self.status = 'Enqueued'
    self.save!
    FileDownloader.enqueue_download(song_url, self)
  end
end
