# app/models/cart.rb

class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_one :order, dependent: :destroy

  before_create :set_default_status

  def self.ransackable_associations(auth_object = nil)
    ["cart_items", "customer", "products"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "secret_id", "status", "updated_at"]
  end

  def add_product(product_id, quantity)
    current_item = cart_items.find_or_initialize_by(product_id: product_id)
    current_item.quantity = (current_item.quantity || 0) + quantity.to_i
    current_item.save
    current_item
  end

  def total_price
    cart_items.to_a.sum { |item| item.product.price * item.quantity }
  end

  private

  def set_default_status
    self.status ||= 'active'
  end
end
