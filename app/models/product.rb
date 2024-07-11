# app/models/product.rb
class Product < ApplicationRecord
  has_many :order_items
  has_many :cart_items
 # belongs_to :category

  validates :item_description, :stock_quantity, :category, presence: true
end
