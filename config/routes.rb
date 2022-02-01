Rails.application.routes.draw do
  devise_for :users
  root to: 'haikus#index'
  resources :users, only: [:edit, :update, :show]
  get '/users', to: 'haikus#index'
  resources :haikus, only: [:index]
  resources :themes, only: [:new, :create]
end
