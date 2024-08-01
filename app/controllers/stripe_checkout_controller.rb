# app/controllers/stripe_checkout_controller.rb
class StripeCheckoutController < ApplicationController
  before_action :authenticate_customer!

  def create
    @customer = current_customer
    @cart = @customer.current_cart
    @taxes = Tax.find_by(province: @customer.province) # Ensure taxes are calculated based on the customer's province
    calculate_totals

    @order = @customer.orders.find_by(status: 'pending', cart: @cart) || @customer.orders.build(status: 'pending', cart: @cart)
    @order.assign_attributes(
      total_price: @subtotal,
      gst_amount: @gst,
      pst_amount: @pst,
      hst_amount: @hst,
      qst_amount: @qst,
      total_tax_amount: @total_tax,
      total_price_with_tax: @grand_total
    )
    @order.save(validate: false)

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: line_items_with_tax,
      mode: 'payment',
      success_url: success_orders_url(order_id: @order.id),
      cancel_url: new_order_url,
      client_reference_id: @cart.secret_id
    })

    @session_id = session.id
    render 'stripe_checkout/checkout'
  end

  private

  def line_items_with_tax
    items = @cart.cart_items.map do |item|
      {
        price_data: {
          currency: 'cad',
          unit_amount: (item.product.price * 100).to_i, # amount in cents
          product_data: {
            name: item.product.item_description
          },
        },
        quantity: item.quantity,
      }
    end

    # Add tax as a separate line item
    if @total_tax.positive?
      items << {
        price_data: {
          currency: 'cad',
          unit_amount: (@total_tax * 100).to_i, # amount in cents
          product_data: {
            name: 'Tax'
          },
        },
        quantity: 1,
      }
    end

    items
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
