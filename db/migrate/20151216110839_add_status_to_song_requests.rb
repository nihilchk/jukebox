class AddStatusToSongRequests < ActiveRecord::Migration
  def change
    add_column :song_requests, :status, :char
  end
end
