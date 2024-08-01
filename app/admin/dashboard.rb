# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    # Section for Total Sales
    columns do
      column do
        panel "Total Sales" do
          total_sales = Order.where(status: 'paid').sum(:total_amount)
          para "Total Sales: #{number_to_currency(total_sales)}"
        end
      end
    end

    # Section for Orders List
    columns do
      column do
        panel "Recent Orders" do
          table_for Order.order('created_at desc').limit(10) do
            column("Order ID", :id)
            column("Customer") { |order| order.customer.name }
            column("Total Amount") { |order| number_to_currency(order.total_amount) }
            column("Status") { |order| order.status }
            column("Order Date", :created_at)
          end
        end
      end
    end
  end # content
end
