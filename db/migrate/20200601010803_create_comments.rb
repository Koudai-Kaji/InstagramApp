class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :user_image_id
      t.text :body

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :user_image_id
    add_index :comments, [:user_id, :user_image_id, :created_at]
  end
end
