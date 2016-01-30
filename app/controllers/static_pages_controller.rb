class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # 現在のユーザーに紐づくMicropostインスタンスを格納
      @micropost = current_user.microposts.build
      
      # 現在のユーザーがフォローしている投稿を取得
      # includes(:user)は投稿に含まれるユーザー情報を同時に取得する
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
