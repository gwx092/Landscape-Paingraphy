class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      #追加したカラム
      t.integer :tag_id
      t.integer :post_id, null: false
      
      t.timestamps
    end
  end
end
