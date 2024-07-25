# app/models/cart.rb
class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items
  has_many :products, through: :cart_items

  before_create :set_default_status

  def add_product(product_id, quantity)
    current_item = cart_items.find_or_initialize_by(product_id: product_id)
    current_item.quantity = (current_item.quantity || 0) + quantity.to_i
    current_item
  end

  private

  def set_default_status
    self.status ||= 'active'
  end

  def total_price
    cart_items.to_a.sum { |item| item.product.price * item.quantity }
  end
end
