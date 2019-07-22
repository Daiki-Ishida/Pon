Rails.application.routes.draw do
  root to: 'pages#top'
  # get  '/about',   to: 'pages#about'
  # get  '/help',   to: 'pages#help'
  # get  '/faq',   to: 'pages#faq'


  resources :users do
    member do
      get :followings, to: 'following_users'
      get :followers
    end
    collection do
      get :territory
      get :followings
      get :search
    end
  end

  namespace :my do
    get :ferrets
    get :rooms
    get :territory
    patch :update_territory
    get :followings
    get :settings
    get :notifications
  end

  resources :ferrets do
    collection do
      get :territory
      get :followings
      get :search
    end
  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    collection do
      get :territory
      get :followings
      get :search
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
    resources :reviews
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # LINEログイン
  # devise_for :users, controllers: {
  #   omniauth_callbacks: "omniauth_callbacks"
  # }

end
