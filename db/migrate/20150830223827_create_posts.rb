class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :post_username
      t.text :post_content
      t.string :file

      t.timestamps null: false
    end
  end
end
