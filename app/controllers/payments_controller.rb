# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def new
    @cart = current_cart
  end

  def create
    @amount = (current_cart.total_price * 100).to_i # amount in cents

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )

    current_cart.update(status: 'completed')
    redirect_to cart_path(current_cart)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
