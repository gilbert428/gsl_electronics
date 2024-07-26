class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  # other associations and validations

  enum status: { pending: 0, paid: 1, canceled: 2 }

  def calculate_total
    self.total_amount = order_items.sum('quantity * price')
  end
end
