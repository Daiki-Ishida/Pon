Rails.application.routes.draw do
  root to: 'pages#top'
  # get  '/about',   to: 'pages#about'
  # get  '/help',   to: 'pages#help'
  # get  '/faq',   to: 'pages#faq'


  resources :users do
    member do
      get :followings, to: 'users#following_users'
      get :followers
    end
    collection do
      get :territory
      get :followings
      get :search
      get :sort
    end
  end

  # メール認証のためのpathra
  resources :account_activations, only: [:edit]

  namespace :my do
    get :page
    get :ferrets
    get :posts
    get :rooms
    get :territory
    patch :update_territory
    get :followings
    get :settings
    get :notifications
    patch :update_status
  end

  resources :ferrets do
    collection do
      get :territory
      get :followings
      get :search
      get :sort
    end
  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    collection do
      get :territory
      get :followings
      get :search
      get :sort
    end
  end

  resources :comments

  resources :relationships, only: [:create, :destroy]

  resources :rooms, only: [:create, :show] do
    resource :messages, only: [:create]
  end

  resources :requests do
    resource :contracts, only: [:create]
  end

  resources :contracts, except: [:create] do
    resources :reports
    resources :reviews, only: [:new, :create]
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # LINEログイン
  # devise_for :users, controllers: {
  #   omniauth_callbacks: "omniauth_callbacks"
  # }

end
