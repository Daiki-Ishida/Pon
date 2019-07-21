Rails.application.routes.draw do
  root to: 'pages#top'

  resources :users do
    member do
      get :followings, :followers
      patch :update_territory
    end
    collection do
      get :rooms
      get :territory
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
