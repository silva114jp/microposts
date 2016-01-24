class Micropost < ActiveRecord::Base
  
  # 投稿は必ず一人のユーザーを持つ
  belongs_to :user
  
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
