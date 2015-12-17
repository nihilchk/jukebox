class SongRequestsController < ApplicationController
  before_action :set_song_request, only: [:retry, :enqueue]

  def index
    @song_requests = SongRequest.all
  end

  def new
    @song_request = SongRequest.new
  end

  def retry
    @song_request.download_file
    @song_requests = SongRequest.all
    render 'index'
  end

  def create
    @song_request = SongRequest.new(song_request_params)

    respond_to do |format|
      if @song_request.save
        format.html { redirect_to action: :index }
        format.json { render :show, status: :created, location: @song_request }
      else
        format.html { render :new }
        format.json { render json: @song_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def enqueue
    Resque.enqueue(PlaySong, @song_request.id)
    Resque.enqueue(PlaySongPlayer, @song_request.id)
    render json: {status: @song_request.status, id: @song_request.id}
  end

  private
    def set_song_request
      @song_request = SongRequest.find(params[:id])
    end

    def song_request_params
      params.require(:song_request).permit(:dedicated_to, :song_url, :message, :requestor)
    end
end
