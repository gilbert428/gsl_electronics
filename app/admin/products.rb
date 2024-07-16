# app/admin/product.rb

ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :item_description, :stock_quantity, :brand, :category, :sub_category, :color, :storage_capacity, :price, :image_link, :sku
  #
  # or
  #
  # permit_params do
  #   permitted = [:item_description, :stock_quantity, :brand, :category, :sub_category, :color, :storage_capacity, :price, :image_link, :sku]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :item_description, :stock_quantity, :brand, :category_id, :sub_category, :color, :storage_capacity, :price, :image_link, :sale, :sku

  index do
    selectable_column
    id_column
    column :item_description
    column :brand
    column :category
    column :sub_category
    column :color
    column :storage_capacity
        column :price
    column :stock_quantity
    column :image_link
    column :sku
    column :sale
    actions
  end

  filter :item_description
  filter :brand
  filter :category
  filter :sub_category
  filter :color
  filter :storage_capacity
  filter :price
  filter :stock_quantity
  filter :sku
  filter :sale

  form do |f|
    f.inputs do
      f.input :item_description
      f.input :brand, input_html: { value: 'Apple' }
      f.input :category_id, as: :select, collection: Category.pluck(:name, :id), include_blank: false, label: 'Category'
      f.input :sub_category, as: :select, collection: Product.distinct.pluck(:sub_category).compact, include_blank: false
      f.input :color
      f.input :storage_capacity
      f.input :price
      f.input :stock_quantity
      f.input :image_link
      f.input :sku
      f.input :sale
    end
    f.actions
  end
end
