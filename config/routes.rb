Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get 'users/sign_up', to: 'users#new'
  get '/users/sign_in', to: 'sessions#new'
  post '/users/sign_in', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy'
  resources :users
end
