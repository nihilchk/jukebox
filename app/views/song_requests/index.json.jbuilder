json.array!(@song_requests) do |song_request|
  json.extract! song_request, :id, :dedicated_to, :song_url, :message, :requestor, :file_id
  json.url song_request_url(song_request, format: :json)
end
