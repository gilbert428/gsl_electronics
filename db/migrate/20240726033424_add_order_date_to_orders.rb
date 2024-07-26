class AddOrderDateToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_date, :datetime
  end
end
