# app/models/product.rb
class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  belongs_to :category
  has_many :carts, through: :cart_items

  has_one_attached :image

  validates :sub_category, presence: true

  # Ransack configuration
  def self.ransackable_attributes(auth_object = nil)
    %w[brand category color created_at id image_link item_description price stock_quantity storage_capacity sub_category updated_at sale]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items order_items category]
  end
end
