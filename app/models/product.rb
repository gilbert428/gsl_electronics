# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  has_many :cart_items

  validates :item_description, :stock_quantity, :brand, :category, :price, presence: true
end
