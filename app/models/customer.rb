# app/models/customer.rb
class Customer < ApplicationRecord
  has_many :orders
  has_many :addresses
  has_many :admins
  has_many :carts

  has_secure_password

  validates :name, :email, :password_digest, :address, :province, presence: true
end
