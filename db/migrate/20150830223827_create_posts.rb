class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      
      t.string :post_username
      t.text :post_content
      t.string :my_image

      t.timestamps null: false
    end
  end
end
