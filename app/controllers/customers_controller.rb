# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update]

  def update
    if @customer.update(customer_params)
      redirect_to cart_path, notice: 'Customer details were successfully updated.'
    else
      render 'carts/show'
    end
  end

  private

  def set_customer
    @customer = current_customer
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :province)
  end
end
