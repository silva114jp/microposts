class Micropost < ActiveRecord::Base
  
  # 投稿は必ず一人のユーザーを持つ
  belongs_to :user
  
  # 一つの投稿は複数のユーザーからお気に入りに設定され得る
  has_many :favorites,
    class_name: "Favorite",
    foreign_key: "micropost_id",
    dependent: :destroy
    
  has_many :favorite_users,
    through: :favorites,
    source: :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
  def favorite_for(user)
    favorites.find_by(user_id: user)
  end
end
