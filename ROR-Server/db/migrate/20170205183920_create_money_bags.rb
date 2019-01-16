class CreateMoneyBags < ActiveRecord::Migration[5.0]
  def change
    create_table :money_bags do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :available_credit
      t.integer :expenses
      t.timestamps
    end
  end
end
