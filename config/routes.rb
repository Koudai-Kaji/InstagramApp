Rails.application.routes.draw do

  root   'static_pages#home'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :password_updates, only: [:edit, :update]
  resources :user_images,      only: [:index, :show, :new, :create, :destroy]
  resources :relationships,    only: [:create, :destroy]
  resources :likes,            only: [:create, :destroy]
  resources :comments,         only: [:create, :destroy]
  resources :notifications,    only: [:index]

end
