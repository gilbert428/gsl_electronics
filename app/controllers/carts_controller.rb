class CartsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]

  def show
    @cart = current_cart
    if @cart.nil?
      redirect_to new_customer_session_path, alert: 'Please sign in to continue.'
    else
      @customer = current_customer
      @taxes = Tax.find_by(province: @customer.province)
    end
  end

  private

  def current_cart
    current_customer.carts.find_or_create_by(status: 'active')
  end
end
