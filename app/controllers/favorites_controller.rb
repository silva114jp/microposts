class FavoritesController < ApplicationController
  before_action :logged_in_user
  
  def create
    #@favorite = favorites.find_or_create_by(micropost_id: micropost.id)
    @favorite = Favorite.find_or_create_by(micropost_id: params[:micropost_id], user_id: current_user.id)
    render layout: nil
  end
  
  def destroy
    @favorite = Favorite.find_by(params[:id])
    @favorite.destroy
  end
end