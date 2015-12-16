class SongRequest < ActiveRecord::Base
  validates_presence_of :dedicated_to, :song_url, :message, :requestor
  validates_format_of :song_url, :with => /(http|https):\/\/www[.]youtube[.]com\/watch[?]v=.*/ix

  before_create :set_fields
  after_create :download_file
  default_scope { order ('id DESC') }
  def set_fields
    description_text = %x{youtube-dl --get-title --get-description #{self.song_url}}
    if description_text.length > 255
      self.description = description_text[1..240] + "..."
    else
      self.description = description_text
    end
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
