class AddNoticeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :notice, :integer, default: 0
  end
end
