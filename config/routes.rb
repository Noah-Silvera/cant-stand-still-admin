require 'sidekiq/web'

Rails.application.routes.draw do
  match '/login', as: :login, via: [:post], controller: :auth, action: :login
  match '/logout', as: :logout, via: [:post], controller: :auth, action: :logout

  resources :riders, only: [:show, :index] do
    resources :trips
  end

  mount Sidekiq::Web => '/sidekiq'
end
