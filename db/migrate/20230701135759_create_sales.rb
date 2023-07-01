class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :customer, null: false, foreign_key: { to_table: :users }
      t.references :salesperson, null: false, foreign_key: { to_table: :users }
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
