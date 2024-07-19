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

    permit_params :item_description, :stock_quantity, :brand, :category_id, :sub_category, :color, :storage_capacity, :price, :image_link, :sku, :image

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
      column "Image" do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "50x50"
        end
      end
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

    form do |f|
      f.inputs do
        f.input :item_description
        f.input :brand, input_html: { value: 'Apple' } # Set default brand to "Apple"
        f.input :category, as: :select, collection: Category.pluck(:name, :id), include_blank: false
        f.input :sub_category, as: :select, collection: Product.distinct.pluck(:sub_category).compact, include_blank: false
        f.input :color
        f.input :storage_capacity
        f.input :price
        f.input :stock_quantity
        f.input :image_link
        f.input :image, as: :file
      end
      f.actions
    end

    show do
      attributes_table do
        row :item_description
        row :brand
        row :category
        row :sub_category
        row :color
        row :storage_capacity
        row :price
        row :stock_quantity
        row :image_link
        row :image do |product|
          if product.image.attached?
            image_tag url_for(product.image), size: "200x200"
          end
        end
      end
      active_admin_comments
    end
  end
