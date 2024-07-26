# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def success
    @order = Order.find(params[:order_id])
    if @order.update(status: 'paid', order_date: Time.current)
      @order.customer.current_cart.cart_items.destroy_all
      flash[:notice] = "Order successfully paid!"
      redirect_to order_path(@order)
    else
      flash[:alert] = "There was an issue processing your order."
      redirect_to root_path
    end
  end

  def cancel
    flash[:alert] = "Payment canceled."
    redirect_to root_path
  end
end
