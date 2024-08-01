# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def show
    @cart = current_cart
    if @cart.nil?
      redirect_to new_customer_session_path, alert: 'Please sign in to continue.'
    else
      @customer = current_customer
      @taxes = Tax.find_by(province: @customer.province)
      calculate_totals
    end
  end

  private

  def current_cart
    current_customer.carts.find_or_create_by(status: 'active')
  end

  def calculate_totals
    @subtotal = @cart.cart_items.sum { |item| item.product.price * item.quantity }

    # Convert tax rates to percentage if they are provided in decimal form
    gst_rate = @taxes&.gst_rate || 0
    pst_rate = @taxes&.pst_rate || 0
    hst_rate = @taxes&.hst_rate || 0
    qst_rate = @taxes&.qst_rate || 0

    # Handle tax rates that are provided as decimals (e.g., 0.05 for 5%) and convert if necessary
    gst_rate = gst_rate < 1 ? gst_rate : gst_rate / 100
    pst_rate = pst_rate < 1 ? pst_rate : pst_rate / 100
    hst_rate = hst_rate < 1 ? hst_rate : hst_rate / 100
    qst_rate = qst_rate < 1 ? qst_rate : qst_rate / 100

    @gst = @subtotal * gst_rate
    @pst = @subtotal * pst_rate
    @hst = @subtotal * hst_rate
    @qst = @subtotal * qst_rate
    @total_tax = @gst + @pst + @hst + @qst
    @grand_total = @subtotal + @total_tax
  end
end
