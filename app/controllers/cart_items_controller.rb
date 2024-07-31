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

  def update
    @cart_item = CartItem.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_to cart_path(current_cart), notice: 'Cart item was successfully updated.'
    else
      redirect_to cart_path(current_cart), alert: 'Failed to update cart item.'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(current_cart), notice: 'Cart item was successfully removed.'
  end

  private

  def current_cart
    current_customer.carts.find_or_create_by(status: 'active')
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
