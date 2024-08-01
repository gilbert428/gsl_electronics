class ChangeStatusTypeInOrders < ActiveRecord::Migration[7.1]
  def up
    # Rename the old status column
    rename_column :orders, :status, :status_string

    # Add a new status column with integer type and default value 0 (pending)
    add_column :orders, :status, :integer, default: 0

    # Copy the data from the old status column to the new status column
    Order.reset_column_information
    Order.find_each do |order|
      order.update_columns(status: Order.statuses[order.status_string]) if order.status_string.present?
    end

    # Remove the old status column
    remove_column :orders, :status_string
  end

  def down
    # Add the old status column back
    add_column :orders, :status_string, :string

    # Copy the data from the new status column to the old status column
    Order.reset_column_information
    Order.find_each do |order|
      order.update_columns(status_string: Order.statuses.key(order.status)) if order.status.present?
    end

    # Remove the new status column
    remove_column :orders, :status

    # Rename the old status column back to status
    rename_column :orders, :status_string, :status
  end
end
