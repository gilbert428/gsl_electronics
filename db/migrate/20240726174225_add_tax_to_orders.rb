# db/migrate/20240726000000_add_tax_to_orders.rb
class AddTaxToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :tax_id, :integer
    add_foreign_key :orders, :taxes
  end
end
