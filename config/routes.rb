Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts do
    collection do
      get :ranking, :following
    end
    resources :comments, only: [:create, :destroy]
  end
  resources :notifications, only: :index
  resources :likes, only: [:create, :destroy]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :relationships,       only: [:create, :destroy]
end
