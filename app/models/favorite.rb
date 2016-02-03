class Favorite < ActiveRecord::Base
  
  # お気に入りはユーザーに紐づく
  belongs_to :user, class_name: "User"
  # お気に入りは投稿を対象とする
  belongs_to :micropost, class_name: "Micropost"
end
