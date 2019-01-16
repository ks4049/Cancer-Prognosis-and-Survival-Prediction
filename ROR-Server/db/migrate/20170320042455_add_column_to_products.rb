class AddColumnToProducts < ActiveRecord::Migration[5.0]
  def change
  	execute "ALTER TABLE products ADD COLUMN image_url varchar(30), ADD COLUMN price varchar(30),ADD COLUMN weight_in_kgs decimal(7,4),ADD COLUMN cholestrol_per_gm decimal(7,4) "
  end
end
