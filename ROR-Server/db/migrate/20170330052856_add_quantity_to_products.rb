class AddQuantityToProducts < ActiveRecord::Migration[5.0]
  def change
  	 execute "ALTER TABLE products ADD COLUMN quantity integer"
  end
end
