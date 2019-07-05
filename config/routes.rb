Rails.application.routes.draw do
  root to: 'pages#top'

  resources :users
  resources :ferrets
  resources :posts
end
