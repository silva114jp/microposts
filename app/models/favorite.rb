class Favorite < ActiveRecord::Base
  
  # お気に入りはユーザーに紐づく
  belongs_to :user
  # お気に入りは投稿を対象とする
  belongs_to :micropost
end
