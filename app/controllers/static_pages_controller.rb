class StaticPagesController < ApplicationController
  def home
    # ログインしている場合、ユーザーに紐づくMicropostインスタンスを格納
    @micropost = current_user.microposts.build if logged_in?
  end
end
