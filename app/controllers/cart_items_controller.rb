class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart = current_cart
    @cart_item = @cart.add_product(params[:product_id], params[:quantity])

    if @cart_item.save
      redirect_to cart_path(@cart), notice: 'Product was successfully added to your cart.'
    else
      redirect_to products_path, alert: 'Unable to add product to cart.'
    end
  end

  private

  def current_cart
    return unless current_customer

    Cart.find_or_create_by(customer_id: current_customer.id)
  end
end
