class AddConstraintsToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :body, false
    change_column_null :comments, :post_id, false
    change_column_null :comments, :commenter_id, false
  end
end
