class AddDescriptionToSongRequests < ActiveRecord::Migration
  def change
    add_column :song_requests, :description, :string
  end
end
