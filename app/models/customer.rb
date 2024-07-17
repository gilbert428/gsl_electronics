# app/models/customer.rb
class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :orders
  has_many :addresses
  has_many :admins
  has_many :carts

  validates :name, :email, :password_digest, :address, :province, presence: true
end
