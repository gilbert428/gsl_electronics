class CartsController < ApplicationController
  before_action :authenticate_customer!, only: [:show]
  before_action :authenticate_customer!, unless: :admin_namespace?

  def show
    @cart = current_cart
    if @cart.nil?
      redirect_to new_customer_session_path, alert: 'Please sign in to continue.'
    end
  end

  private

  def current_cart
    if customer_signed_in?
      current_customer.cart || current_customer.create_cart
    else
      nil
    end
  end
end
