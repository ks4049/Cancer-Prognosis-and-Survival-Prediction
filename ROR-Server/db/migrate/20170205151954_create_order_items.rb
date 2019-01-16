class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :item_total
      t.references :order, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.timestamps
    end
  end
end
