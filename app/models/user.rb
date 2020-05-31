class User < ApplicationRecord
  has_many :user_images, dependent: :destroy
  has_many :active_relationships,   class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
  has_many :passive_relationships,  class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower 
  has_many :likes, dependent: :destroy
  before_save {email.downcase!}
  validates :name, {presence: true, length: {maximum: 50}}
  VALLID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,  {presence: true, length: {maximum: 255},
                      format: {with: VALLID_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}}
  has_secure_password
  validates :password, {presence: true, length: {minimum: 6}, allow_nil: true}
  validates :user_name, {presence: true, length: {maximum: 50}}
  
  
  
  #渡された文字列のハッシュを返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  #ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  #現在のユーザーがフォローしているか確認
  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids  = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    UserImage.where( "user_id in (#{following_ids})
                      OR user_id = :user_id", user_id: id).reorder(created_at: :ASC)
  end



end
