class CreateAudits < ActiveRecord::Migration[5.0]
  def change
    create_table :audits do |t|
      t.references :task, index: true, foreign_key: true
      t.string :status
      t.timestamps
    end
  end
end
