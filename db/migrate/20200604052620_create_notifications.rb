class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :user_image_id
      t.integer :comment_id
      t.string  :action,  default: '',    null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :user_image_id
    add_index :notifications, :comment_id
  end
end
