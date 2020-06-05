class UserImage < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
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


  def create_notification_like(current_user)
    #すでにいいねされているか検索
    temp = Notification.where("visitor_id = ? and visited_id = ? and
                              user_image_id = ? and action = ?",
                              current_user.id, user_id, id, "like")
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.build(
        visited_id: user_id,
        user_image_id: id,
        action: "like"
      )
      #自分の投稿に対するコメントは通知済みとする
      if notification.visitor.id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    #自分以外のコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(user_image_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id[：user_id])
    end
    #投稿者にも通知を送る
    save_notification_comment(current_user, comment_id, user_id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    #コメントは複数回通知されうる
    notification = current_user.active_notifications.build(
      user_image_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    #自分の投稿に対するコメントは通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true 
    end
    notification.save if notification.valid?
  end

end
