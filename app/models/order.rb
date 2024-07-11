# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  validates :total_price, :gst_rate, :pst_rate, :status, presence: true
end
