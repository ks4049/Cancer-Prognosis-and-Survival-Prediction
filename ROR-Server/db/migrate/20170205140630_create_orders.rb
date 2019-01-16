class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
  t.references :user, index: true, foreign_key: true
     t.integer :total
     t.integer :order_number
      t.timestamps
    end
  end
end
