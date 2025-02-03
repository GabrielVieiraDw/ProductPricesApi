Rails.application.routes.draw do
  resources :prices, param: :country, only: [:index, :show, :create]
end
