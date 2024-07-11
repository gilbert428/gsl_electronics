require 'csv'

# Clear existing records
Product.destroy_all
#Category.destroy_all

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
    category = Category.find_or_create_by(name: product['category'])
    puts "Processing product: #{product['item_description']} in category: #{category.name}"

    # Create the product
    created_product = Product.create(
      sku: product['sku'],
      item_description: product['item_description'],
      stock_quantity: product['stock_quantity'],
      brand: product['brand'],
      sub_category: product['sub_category'],
      color: product['color'],
      storage_capacity: product['storage_capacity'],
      price: product['price'],
      image_link: product['image_link'],
      category: product['category']
      #category: category
    )

    if created_product.persisted?
      puts "Product #{created_product.item_description} created successfully."
    else
      puts "Failed to create product #{product['item_description']}. Errors: #{created_product.errors.full_messages.join(', ')}"
    end
  end
else
  puts "CSV file not found"
end
