class AddProfileToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :web_page, :string
    add_column :users, :introduce, :text
    add_column :users, :phone_number, :string
  end
end
