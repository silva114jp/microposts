Rails.application.routes.draw do
  # TOP画面へのルーティング
  root to: 'static_pages#home'
  
  # 新規登録画面/処理へのルーティング
  get 'signup', to: 'users#new'
  
  # ログイン画面/処理へのルーティング
  get 'login', to: 'sessions#new'
  # セッション情報保持へのルーティング
  post 'login', to: 'sessions#create'
  # セッション情報破棄へのルーティング
  delete 'logout', to: 'sessions#destroy'
  
  # フォローしているユーザー画面/処理へのルーティング
  get 'users/:id/followings', to: 'users#followings', as: 'followings'
  # フォローされているユーザー画面/処理へのルーティング
  get 'users/:id/followers', to: 'users#followers', as: 'followers'
  
  # ユーザーが持つお気に入り画面/処理へのルーティング
  get 'users/:id/favorites', to: 'users#favorite_microposts', as: 'favorite_microposts'
  
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
