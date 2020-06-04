class UserImage < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  default_scope -> {order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, {presence: true}
  validates :picture, {presence: true}
  validate  :picture_size
  validates :name, {presence: true}
  validates :name, {length: {maximum: 50}}

  
  #写真をいいねする
  def like_you(user)
    self.likes.create(user_id: user.id)
  end

  #いいねの解除をする
  def unlike_you(user)
    self.likes.find_by(user_id: user.id).destroy
  end

  #ユーザーがいいねしているならtrue
  def like_now?(user)
    self.like_users.include?(user)
  end

  #画像を探す
  def UserImage.serch(serch)
    if serch
      UserImage.where("name LIKE ?", "%#{serch}%")
    else
      UesrImage.all
    end
  end


  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end
