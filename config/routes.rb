Rails.application.routes.draw do
  root to: 'pages#top'
  # get  '/about',   to: 'pages#about'
  # get  '/help',   to: 'pages#help'
  # get  '/faq',   to: 'pages#faq'


  resources :users do
    member do
      # action名がダブってしまうので回避
      get :followings, to: 'users#following_users'
      get :followers
      patch :update_territory
    end
    collection do
      get :ferrets
      get :rooms
      get :territory
      get :followings
      get :search
      get :edit_territory
      get :settings
    end
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
