Rails.application.routes.draw do
  match '/login', as: :login, via: [:post], controller: :auth, action: :login

  resources :riders do
    resources :trips
  end
end
