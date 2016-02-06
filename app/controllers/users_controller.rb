class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :check_logged_in_user, only: [:show, :edit, :update]
  before_action :is_logged_in_current_user,only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  # 新規登録処理
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end
  
  # ユーザ基本情報詳細画面
  def show
    # ユーザーの投稿を降順にしてインスタンス化
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  # ユーザ基本情報の編集画面
  def edit
  end
  
  # ユーザ基本情報の更新処理
  def update
    if @user.update(user_params)
    flash[:success] = "Successful update profile"
    redirect_to @user
    else
    # 保存に失敗した場合は編集画面へ戻す
    render 'edit'
    end
  end
  
  def followings
    # フォローしているユーザーを取得
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers
    # フォローされているユーザーを取得
    @user = User.find(params[:id])
    @followers = @user.follower_users
  end
  
  def favorite_microposts
    # お気に入りの投稿を取得
    @user = User.find(params[:id])
    @favorite_microposts = @user.favorite_microposts.order(created_at: :desc)
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:country,:password,:password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def check_logged_in_user
    # ユーザーがログイン中かチェック
    logged_in_user
  end
  
  def is_logged_in_current_user
    # ログイン中のユーザーは自身の情報のみ参照可能
    if @user != current_user
      flash[:danger] = "Denied to access"
      redirect_to root_url
    end
  end
end