Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'users/:id/followings', to: 'users#followings', as: 'followings'
  get 'users/:id/followers', to: 'users#followers', as: 'followers'
  
  # :idユーザーが持つお気に入り投稿
  get 'users/:id/favorites', to: 'users#favorite_microposts', as: 'favorites'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
