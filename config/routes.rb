Rails.application.routes.draw do

  resources :song_requests, :only => [:index, :create, :new] do
    member do
      put 'retry'
      get 'enqueue'
    end
  end

  get 'search_youtube_videos', controller: 'search_query', action: 'search_youtube_videos'
end
