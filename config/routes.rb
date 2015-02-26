Rails.application.routes.draw do
  root             'static_pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users
  resources :games

  get 'history', to: 'bets#index'
  get 'users/:user_id/games/:game_id/bets/new', to: 'bets#new'
  post 'users/:user_id/games/:game_id/bets', to: 'bets#create'
  get 'bets/review', to: 'bets#review'
  post 'bets/:id', to: 'bets#update'
  get 'bets/:id', to: 'bets#show'
  get 'images/new' => 'images#new'
  post 'images' => 'images#create'
end