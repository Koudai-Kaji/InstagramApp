class Notification < ApplicationRecord
  belongs_to :comment, optional: true
  belongs_to :user_image, optional: true
  belongs_to :visitor, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true
  default_scope -> {order(created_at: :desc)}
end
