Rails.application.routes.draw do
  devise_for :users
  root to: 'haikus#index'
  resources :haikus, only: [:index]
end
