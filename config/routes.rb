Rails.application.routes.draw do
  root to: 'pages#top'

  resources :users do
    member do
      get :followings, :followers
      get :rooms
      get :territory
      patch :update_territory
    end
  end
  resources :ferrets
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
  # resources :messages, only: [:create]
  resources :rooms, only: [:create, :show] do
    resource :messages, only: [:create]
  end

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # LINEログイン
  # devise_for :users, controllers: {
  #   omniauth_callbacks: "omniauth_callbacks"
  # }

end
