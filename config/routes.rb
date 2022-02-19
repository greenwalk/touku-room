Rails.application.routes.draw do
  devise_for :users
  root to: 'fields#index'
  resources :users, only: [:edit, :update, :show]
  get '/users', to: 'fields#index'
  resources :themes, only: [:new, :create, :edit, :update] 
  resources :fields, only: [:index, :show] do
    resources :haikus, only: [:new, :create, :edit, :update] do
      resources :votes, only: [:create, :destroy]
    end
  end
end