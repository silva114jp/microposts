class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private
  def logged_in_user
    unless logged_in?
      # logged_inがfalseの場合に実行される
      store_location
      flash[:danger] = "Please Log in."
      
      # ログイン画面のURLにリダイレクトする
      redirect_to login_url
    end
  end
end
