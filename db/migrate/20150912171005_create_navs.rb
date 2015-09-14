class CreateNavs < ActiveRecord::Migration
  def change
    create_table :navs do |t|
      t.text :myname
      t.text :myage
      t.text :mygender
      t.text :mynationality
      t.text :myetc
      
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
