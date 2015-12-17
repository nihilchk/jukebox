class SongRequestsController < ApplicationController
  before_action :set_song_request, only: [:retry, :enqueue, :show]

  def index
    @song_requests = SongRequest.all
  end

  def new
    @song_request = SongRequest.new
  end

  def show
  end

  def retry
    @song_request.download_file
    redirect_to action: :index
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
    render json: {error: "wrong secret"} and return if params[:admin_secret] != Jukebox::Application.config.admin_secret
    Resque.enqueue(PlaySong, @song_request.id)
    Jukebox::Application.config.master_server_config['other_players'].each do | player_name |
      Resque.enqueue_to(player_name, PlaySongPlayer, @song_request.id)
    end if Jukebox::Application.config.master_server_config['other_players'].present?
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
