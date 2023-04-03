class AddUserRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_reference :likes, :user, null: false, foreign_key: true
    rename_column :likes, :user_id, :author_id
  end
end
