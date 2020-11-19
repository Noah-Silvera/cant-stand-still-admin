require 'sidekiq/web'

Rails.application.routes.draw do
  match '/login', as: :login, via: [:post], controller: :auth, action: :login

  resources :riders, only: [:show, :index] do
    resources :trips
  end

  mount Sidekiq::Web => '/sidekiq'
end
