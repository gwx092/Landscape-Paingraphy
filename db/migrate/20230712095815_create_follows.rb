class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      #追加したカラム
      t.integer :user_id, null: false
      
      t.timestamps
    end
  end
end
