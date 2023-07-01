class CreateJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :sales, :products do |t|
      t.index [:sale_id, :product_id]
      t.index [:product_id, :sale_id]
    end
  end
end
