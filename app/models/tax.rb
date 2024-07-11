# app/models/tax.rb
class Tax < ApplicationRecord
  validates :province, :gst_rate, :pst_rate, presence: true
end
