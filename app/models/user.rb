class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name ,presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email ,
    presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false}
    
  has_secure_password
  
  # ユーザーは複数の投稿を持つことができる
  has_many :microposts
  
  has_many :following_relationships,
    class_name: "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy
    
  has_many :following_users,
    through: :following_relationships,
    source: :followed
    
  has_many :follower_relationships,
    class_name: "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy
    
  has_many :follower_users,
    through: :follower_relationships,
    source: :follower
  
  # 他のユーザーをフォローする
  def follow(other_user)
    # 現在のユーザーのfollowing_relationshipsの中から
    # フォローするユーザーのuser_idを含むものを探し、存在しない場合は、新しく作成します。
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    # following_relationshipsからフォローしているユーザーの
    # user_idが入っているものを探し、存在する場合は削除します。
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  
  # あるユーザーをフォローしているかどうか
  def following?(other_user)
    # 他のユーザーがfollowing_usersに含まれているかチェックしています。
    following_users.include?(other_user)
  end
  
  # user_idがフォローしているユーザーと自分のつぶやきを取得
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
end
