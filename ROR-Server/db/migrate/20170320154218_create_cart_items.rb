class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.string :product_name
      t.string :price
      t.string :image_url
      t.integer :user_id
      t.timestamps
    end
  end
end
