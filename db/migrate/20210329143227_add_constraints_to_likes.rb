class AddConstraintsToLikes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :likes, :liker_id, false
    change_column_null :likes, :post_id, false
    add_index :likes, [:liker_id, :post_id], unique: true
  end
end
