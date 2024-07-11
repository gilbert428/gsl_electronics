# app/models/admin_user.rb

class AdminUser < ApplicationRecord
       # Devise modules
       devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

       # ActiveAdmin-specific configuration
       def self.ransackable_attributes(auth_object = nil)
         ["created_at", "email", "encrypted_password", "id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
       end
     end
