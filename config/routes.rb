Rails.application.routes.draw do

  resources :song_requests, :only => [:index, :create, :new] do
    member do
      put 'retry'
    end
  end
end
