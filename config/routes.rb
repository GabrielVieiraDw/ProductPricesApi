Rails.application.routes.draw do
  resources :prices, only: [:index, :show, :create]
end
