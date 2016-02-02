class SessionsController < ApplicationController
  def new
  end
  
  def create
    # ユーザをメールアドレスから検索
    @user = User.find_by(email: params[:session][:email].downcase)
    
    # ユーザが存在した場合、パスワードが正しいかチェック
    if @user && @user.authenticate(params[:session][:password])
      # ユーザーIDをセッション保持し、ユーザの詳細ページへリダイレクトする
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"
      
      # ログイン後は、MicropostFeed画面に遷移する
      # redirect_to @user
      redirect_to root_path
    else
      # パスワードが誤っている場合、newテンプレートを表示
      flash[:danger] = 'invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    # セッションのユーザIDを破棄し、ルートへリダイレクト
    session[:user_id] = nil
    redirect_to root_path
  end
end