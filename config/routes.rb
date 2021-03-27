require 'sidekiq/web'

Rails.application.routes.draw do
  root "trips#index"

  match '/auth/:provider/callback', to: "sessions#create", via: [:get, :post]

  resources :riders, only: [:show, :index] do
    resources :trips
  end

  get "/login", to: 'sessions#login'
  get "/logout", to: 'sessions#logout'

  get '/', to: redirect('/trips')
  get '/trips', to: 'trips#index'

  mount Sidekiq::Web => '/sidekiq'
end
