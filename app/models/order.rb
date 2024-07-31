# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :tax, optional: true
  has_many :order_items

  enum status: { pending: 0, paid: 1, canceled: 2 }

  before_create :set_tax

  def calculate_total
    self.total_amount = order_items.sum('quantity * price')
    calculate_tax if tax.present?
  end

  private

  def set_tax
    self.tax = Tax.find_by(province: customer.province)
  end

  def calculate_tax
    self.gst_amount = total_amount * tax.gst_rate / 100
    self.pst_amount = total_amount * tax.pst_rate / 100
    self.hst_amount = total_amount * tax.hst_rate / 100
    self.qst_amount = total_amount * tax.qst_rate / 100
    self.total_tax_amount = gst_amount + pst_amount + hst_amount + qst_amount
    self.total_price_with_tax = total_amount + total_tax_amount
  end
end
