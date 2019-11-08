Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  root 'static_pages#home'
  get 'sessions/explanation', to: 'static_pages#explanation', as: 'explanation'
  get '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/test-user-login', to: 'sessions#test_user_login', as: 'test_user_login'
  resources :users do
    member do
      get :following, :followers, :posts
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
