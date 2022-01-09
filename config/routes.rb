Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'home#index'
  get    '/login',     to: 'sessions#new'
  post    '/login',     to: 'sessions#create'
  delete  '/logout',    to: 'sessions#destroy'
  resources :users, only: %i[show new create]
  resources :posts, only: %i[show new create edit update destroy]
end
