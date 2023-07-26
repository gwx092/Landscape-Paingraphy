class AddDetailsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :tag_body, :text
  end
end
