class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      #追加したカラム
      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.string :comment, null: false
      
      t.timestamps
    end
  end
end
