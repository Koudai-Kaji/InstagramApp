class AddNameToUserImages < ActiveRecord::Migration[5.1]
  def change
    add_column :user_images, :name, :string
    add_index :user_images, :name
  end
end
