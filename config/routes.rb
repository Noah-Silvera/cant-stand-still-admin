require 'sidekiq/web'

Rails.application.routes.draw do
  root "trips#index"

  match '/login', as: :login, via: [:post], controller: :auth, action: :login
  match '/logout', as: :logout, via: [:post], controller: :auth, action: :logout

  resources :riders, only: [:show, :index] do
    resources :trips
  end


  get '/:rider_id', to: 'trips#index'

  mount Sidekiq::Web => '/sidekiq'
end
