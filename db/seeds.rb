require 'csv'

# Clear existing records
Product.destroy_all
Category.destroy_all

# Path to the CSV file
csv_file = Rails.root.join('db/products.csv')

# Check if the CSV file exists
if File.exist?(csv_file)
  puts "CSV file found. Proceeding with seeding..."
  # Read the CSV data
  csv_data = File.read(csv_file)
  products = CSV.parse(csv_data, headers: true)

  # Iterate through each row in the CSV file
  products.each do |product|
    # Find or create the category
    category_name = product['category']
    category = Category.find_or_create_by(name: category_name)
    if category.persisted?
      puts "Category '#{category_name}' (ID: #{category.id}) found or created successfully."
    else
      puts "Failed to create/find category '#{category_name}'. Errors: #{category.errors.full_messages.join(', ')}"
    end

    # Create the product
    created_product = Product.create(
      sku: product['sku'],
      item_description: product['item_description'],
      stock_quantity: product['stock_quantity'],
      brand: product['brand'],
      sub_category: product['sub_category'],
      color: product['color'],
      storage_capacity: product['storage_capacity'],
      price: product['price'].to_i,
      image_link: product['image_link'],
      category: category
    )

    if created_product.persisted?
      puts "Product '#{created_product.item_description}' created successfully with Category ID: #{created_product.category_id}."
    else
      puts "Failed to create product '#{product['item_description']}'. Errors: #{created_product.errors.full_messages.join(', ')}"
    end

    # Verify the category association
    if created_product.category.present?
      puts "Product '#{created_product.item_description}' is correctly associated with Category '#{created_product.category.name}' (ID: #{created_product.category.id})."
    else
      puts "Product '#{created_product.item_description}' is not associated with any category."
    end
  end
else
  puts "CSV file not found"
end
