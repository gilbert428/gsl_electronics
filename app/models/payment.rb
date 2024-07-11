# app/models/payment.rb
class Payment < ApplicationRecord
  belongs_to :order

  validates :payment_method, :amount, :payment_date, presence: true
end
