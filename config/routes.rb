Rails.application.routes.draw do
  resources :riders do
    resources :trips
  end
end
