class AddColumnsToProductCategories < ActiveRecord::Migration[5.0]
  def change
  	execute "ALTER TABLE product_categories ADD COLUMN image_url varchar(30),ADD COLUMN redirect_url varchar(30)"
  end
end
