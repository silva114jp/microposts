class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
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
  
  private
  def user_params
    params.require(:user).permit(:name,:email,:country,:password,:password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end