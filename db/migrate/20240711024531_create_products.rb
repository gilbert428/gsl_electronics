class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :sku
      t.string :item_description
      t.integer :stock_quantity
      t.string :brand
      t.string :category
      t.string :sub_category
      t.string :color
      t.string :storage_capacity
      t.integer :price
      t.string :image_link

      t.timestamps
    end
  end
end
