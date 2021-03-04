class CreateCommentsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :post
      t.references :commenter

      t.timestamps
    end
  end
end
