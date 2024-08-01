# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart, only: [:new, :create, :update_customer_info]

  def index
    @orders = current_customer.orders.order(created_at: :desc)
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def new
    @order = current_customer.orders.find_by(status: 'pending', cart: @cart) || current_customer.orders.build(cart: @cart, status: :pending)
    @order.ensure_tax if @order.new_record? # Ensure tax is set before updating the order
    update_order_from_cart(@order, @cart)

    if @order.total_price_with_tax >= minimum_amount_in_cents / 100.0
      @order.save(validate: false) # Save without validation to calculate total_amount
      begin
        @checkout_session = StripePaymentService.new(@order).create_checkout_session
      rescue => e
        flash[:alert] = "Error creating checkout session: #{e.message}"
        @checkout_session = nil
      end
    else
      flash[:alert] = "Order amount is too low to process payment."
    end
  end

  def create
    @order = current_customer.orders.find_by(status: 'pending', cart: @cart) || current_customer.orders.build(cart: @cart, status: :pending)
    @order.ensure_tax if @order.new_record? # Ensure tax is set before updating the order
    update_order_from_cart(@order, @cart)
    if @order.save && update_customer_info
      redirect_to success_order_path(@order), notice: 'Order created successfully.'
    else
      render :new
    end
  end

  def success
    @order = Order.find_by(id: params[:order_id])
    if @order&.update(status: :paid, order_date: Time.current)
      @order.customer.current_cart.cart_items.destroy_all
      flash[:notice] = "Order successfully paid!"
      render 'orders/success'
    else
      flash[:alert] = "There was an issue updating the order status."
      redirect_to orders_path
    end
  end

  def update_customer_info
    if current_customer.update(customer_params)
      @order = current_customer.orders.find_by(status: 'pending', cart: @cart) || current_customer.orders.build(cart: @cart, status: :pending)
      if @order.new_record?
        @order.ensure_tax # Ensure tax is set before updating the order
      end
      update_order_from_cart(@order, @cart)
      respond_to do |format|
        format.html { redirect_to new_order_path, notice: 'Customer information updated.' }
        format.json { render json: tax_breakdown_json(@order) }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { error: 'Failed to update customer information.' }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_cart
    @cart = current_customer.current_cart
  end

  def order_params
    params.require(:order).permit(:address, :city, :province, :zip_code, :country, :phone, order_items_attributes: [:product_id, :quantity, :price])
  end

  def customer_params
    params.require(:customer).permit(:address, :city, :province, :zip_code, :country, :phone)
  end

  def update_order_from_cart(order, cart)
    order.order_items.destroy_all # Clear existing order items to update with current cart items
    cart.cart_items.each do |cart_item|
      order.order_items.build(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price)
    end
    order.calculate_total
    order.calculate_tax # Ensure tax is calculated and included
  end

  def minimum_amount_in_cents
    50 # Minimum amount in cents (0.50 CAD)
  end

  def tax_breakdown_json(order)
    {
      subtotal: number_to_currency(order.total_amount, unit: "CAD$"),
      gst: number_to_currency(order.gst_amount, unit: "CAD$"),
      pst: number_to_currency(order.pst_amount, unit: "CAD$"),
      hst: number_to_currency(order.hst_amount, unit: "CAD$"),
      qst: number_to_currency(order.qst_amount, unit: "CAD$"),
      total: number_to_currency(order.total_price_with_tax, unit: "CAD$")
    }
  end
end
