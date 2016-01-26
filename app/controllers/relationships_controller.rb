class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end
  
  def destroy
    # 現在のユーザーのフォローされているユーザーを探し、
    # フォローされているユーザーを引数として、unfollowを実行
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
