class Like < ApplicationRecord
  belongs_to :user
  belongs_to :user_image
  validates :user_id,       {presence: true}
  validates :user_image_id, {presence: true}
end
