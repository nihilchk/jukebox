class CreateSongRequests < ActiveRecord::Migration
  def change
    create_table :song_requests do |t|
      t.string :dedicated_to
      t.string :song_url
      t.text :message
      t.string :requestor
      t.string :file_id

      t.timestamps null: false
    end
  end
end
