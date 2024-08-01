# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :tax, optional: true
  belongs_to :cart
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, paid: 1, shipped: 2 }

  before_create :set_default_status, :set_tax

  def self.ransackable_associations(auth_object = nil)
    ["cart", "customer", "order_items", "tax"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["cart_id", "created_at", "customer_id", "gst_amount", "gst_rate", "hst_amount", "hst_rate", "id", "id_value", "order_date", "pst_amount", "pst_rate", "qst_amount", "qst_rate", "status", "tax_id", "total_amount", "total_price", "total_price_with_tax", "total_tax_amount", "updated_at"]
  end

  def calculate_total
    self.total_amount = order_items.sum('quantity * price')
    calculate_tax
  end

  def calculate_tax
    return unless tax.present? # Ensure tax is present

    self.gst_amount = total_amount * tax.gst_rate / 100
    self.pst_amount = total_amount * tax.pst_rate / 100
    self.hst_amount = total_amount * tax.hst_rate / 100
    self.qst_amount = total_amount * tax.qst_rate / 100
    self.total_tax_amount = gst_amount + pst_amount + hst_amount + qst_amount
    self.total_price_with_tax = total_amount + total_tax_amount
  end

  def ensure_tax
    set_tax
  end

  private

  def set_default_status
    self.status ||= :pending
  end

  def set_tax
    self.tax = Tax.find_by(province: customer.province)
  end
end
