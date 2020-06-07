class CreateUserImages < ActiveRecord::Migration[5.1]
  def change
    create_table :user_images do |t|
      t.string :picture
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :user_images, [:user_id, :created_at]
  end
end
