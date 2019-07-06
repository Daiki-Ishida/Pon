Rails.application.routes.draw do
  root to: 'pages#top'

  resources :users
  resources :ferrets
  resources :posts
  resources :comments
  resources :like, only: [:create, :destroy]
  
end
