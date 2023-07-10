class AddPriceToSales < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :price, :float
  end
end
