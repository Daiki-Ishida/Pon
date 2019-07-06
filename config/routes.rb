Rails.application.routes.draw do
  root to: 'pages#top'

  resources :users
  resources :ferrets
  resources :posts do
    resource :likes, only: [:create, :destroy]
  end
  resources :comments
  resources :relationships, only: [:create, :destroy]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # LINEログイン
  # devise_for :users, controllers: {
  #   omniauth_callbacks: "omniauth_callbacks"
  # }

end
