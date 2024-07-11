# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'

CSV.foreach(Rails.root.join('C:/Users/gilbe/Documents/WEBD-3011_(255576)_AgileFullStackWebDevelopment_Diogo/introRails_eCommerce/products.csv'), headers: true) do |row|
  Product.create(
    item_description: row['item_description'],
    stock_quantity: row['stock_quantity'],
    brand: row['brand'],
    category: row['category'],
    sub_category: row['sub_category'],
    color: row['color'],
    storage_capacity: row['storage_capacity'],
    price: row['price'],
    image_link: row['image_link']
  )
end
