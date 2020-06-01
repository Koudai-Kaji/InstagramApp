class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :user_image
  default_scope -> {order(created_at: :desc)}
  validates :user_id,       {presence: true}
  validates :user_image_id, {presence: true}
  validates :body, {presence: true, length: {maximum: 140}}

end
