class AlterColumnOfOrderItem < ActiveRecord::Migration[5.0]
  def change
  	execute "ALTER table order_items ALTER COLUMN item_total TYPE varchar(10)"
  end
end
