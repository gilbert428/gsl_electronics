# app/controllers/stripe_checkout_controller.rb
class StripeCheckoutController < ApplicationController
  before_action :authenticate_customer!


  def create
    @cart = current_cart
    @order = current_customer.orders.create!(status: 'pending') # Create an order here

    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @cart.cart_items.map do |item|
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
      end,
      mode: 'payment',
      success_url: success_orders_url(order_id: @order.id),
      cancel_url: cancel_orders_url(order_id: @order.id),
      client_reference_id: @cart.secret_id
    })

    @session_id = session.id
    render 'stripe_checkout/checkout'
  end

  private

  def success_url
    success_orders_url(session_id: '{CHECKOUT_SESSION_ID}')
  end

  def cancel_url
    cancel_orders_url
  end
end
