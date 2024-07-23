# app/controllers/cart_items_controller.rb
class CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart = current_cart
    @cart_item = @cart.add_product(params[:product_id], params[:quantity] || 1)

    if @cart_item.save
      redirect_to cart_path(@cart), notice: 'Product was successfully added to your cart.'
    else
      render :new
    end
  end

  private

  def current_cart
    current_customer.carts.find_or_create_by(status: 'active')
  end
end
