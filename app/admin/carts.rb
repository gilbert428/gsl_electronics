# app/admin/carts.rb
ActiveAdmin.register Cart do
  permit_params :customer_id, :status, :secret_id

  index do
    selectable_column
    id_column
    column :customer
    column :status
    column :secret_id
    column :created_at
    column :updated_at
    actions
  end

  filter :customer
  filter :status
  filter :secret_id
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :customer
      f.input :status
      f.input :secret_id
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :status
      row :secret_id
      row :created_at
      row :updated_at
    end
    panel "Cart Items" do
      table_for cart.cart_items do
        column :product
        column :quantity
        column :created_at
        column :updated_at
      end
    end
    active_admin_comments
  end
end
