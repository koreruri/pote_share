Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get 'users/sign_up', to: 'users#new'
  get 'users/account', to: 'users#show'
  get 'users/profile', to: 'users#profile'
  patch 'users/profile', to: 'users#profile_update'
  get 'users/edit', to: 'users#edit'
  patch 'users/edit', to: 'users#update'
  get '/users/sign_in', to: 'sessions#new'
  post '/users/sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users
end
