Rails.application.routes.draw do
  devise_for :users
  root             'static_pages#home'

  resources :games
  resources :users

  get 'history', to: 'bets#index'
  get 'users/:user_id/games/:game_id/bets/new', to: 'bets#new'
  post 'users/:user_id/games/:game_id/bets', to: 'bets#create'
  get 'bets/review', to: 'bets#review'
  put 'bets/:id', to: 'bets#update'
  patch 'bets/:id', to: 'bets#update'
  get 'bets/:id', to: 'bets#show'
  post 'bets/:id/comments' => 'comments#create'
  get 'images/new' => 'images#new'
  post 'images' => 'images#create'
end