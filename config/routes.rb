Rails.application.routes.draw do
  root to: 'haikus#index'
  resources :haikus, only: [:index]
end
