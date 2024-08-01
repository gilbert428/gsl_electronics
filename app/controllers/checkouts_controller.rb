# app/controllers/checkouts_controller.rb
class CheckoutsController < ApplicationController
  before_action :authenticate_customer!

  def show
    @cart = current_cart
  end

  def address
    @cart = current_cart
    @address = current_customer.address || Address.new
  end

  def confirm
    @cart = current_cart
    @address = current_customer.address || current_customer.build_address(address_params)
    if @address.save
      @order = build_order
      if @order.save
        @cart.update(status: 'completed')
        @cart.cart_items.each do |item|
          @order.order_items.create(product: item.product, quantity: item.quantity, price: item.product.price)
        end
        redirect_to invoice_checkout_path(order_id: @order.id), notice: 'Order successfully placed.'
      else
        render :address
      end
    else
      render :address
    end
  end

  def invoice
    @order = Order.find(params[:order_id])
    @address = @order.customer.address
  end

  private

  def current_cart
    current_customer.carts.find_or_create_by(status: 'active')
  end

  def address_params
    params.require(:address).permit(:address_line_1, :address_line_2, :city, :province, :postal_code)
  end

  def build_order
    order = current_customer.orders.build
    order.total_price = @cart.cart_items.sum { |item| item.product.price * item.quantity }
    tax = Tax.find_by(province: @address.province)
    order.gst_rate = tax.gst_rate
    order.pst_rate = tax.pst_rate
    order.hst_rate = tax.hst_rate
    order.gst_amount = order.total_price * order.gst_rate
    order.pst_amount = order.total_price * order.pst_rate
    order.hst_amount = order.total_price * order.hst_rate
    order.total_tax_amount = order.gst_amount + order.pst_amount + order.hst_amount
    order.total_price_with_tax = order.total_price + order.total_tax_amount
    order.status = 'pending'
    order
  end
end
