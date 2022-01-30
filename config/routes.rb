Rails.application.routes.draw do
  devise_for :users
  root to: 'haikus#index'
  resources :users, only: [:edit, :update, :show]
  resources :haikus, only: [:index]
end
