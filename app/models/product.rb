# app/models/product.rb

class Product < ApplicationRecord
  # Associations
  has_many :cart_items
  has_many :order_items
  belongs_to :category

  validates :sub_category, presence: true

  # Scopes for filtering
  scope :on_sale, -> { where(sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ? AND created_at < ?', 3.days.ago, 3.days.ago) }

  # Ransack configuration
  def self.ransackable_attributes(auth_object = nil)
    %w[brand category color created_at id image_link item_description price stock_quantity storage_capacity sub_category updated_at sale sku]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[cart_items order_items category]
  end
end
