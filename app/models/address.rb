# app/models/address.rb
class Address < ApplicationRecord
  belongs_to :user

  validates :address_line_1, :city, :province, :postal_code, presence: true
end
