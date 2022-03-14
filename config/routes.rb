Rails.application.routes.draw do
  devise_for :users
  root to: 'fields#index'
  resources :users, only: [:edit, :update, :show]
  get '/users', to: 'fields#index'
  resources :themes, only: [:new, :create, :edit, :update] 
  resources :fields, only: [:index, :show] do
    collection do
      get 'rule'
      get 'privacy_policy'
    end
    resources :haikus, only: [:new, :create, :edit, :update, :destroy, :show] do
      resources :votes, only: [:create, :destroy]
    end
  end
end