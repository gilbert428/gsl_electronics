# app/models/customer.rb
class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :addresses
  has_many :admins
  has_many :carts
 has_many :orders
  has_one :current_cart, class_name: 'Cart', foreign_key: 'customer_id'
  validates :name, :email, :address, :province, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "id", "last_sign_in_at", "last_sign_in_ip", "name", "province", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["orders", "addresses", "admins", "carts"]
  end
end
