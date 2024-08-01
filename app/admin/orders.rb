# app/admin/orders.rb

ActiveAdmin.register Order do
  permit_params :status, :customer_id, :cart_id, :total_price, :gst_amount, :pst_amount, :hst_amount, :qst_amount, :total_tax_amount, :total_price_with_tax, :order_date, order_items_attributes: [:product_id, :quantity, :price]

  form do |f|
    f.inputs do
      f.input :customer
      f.input :cart
      f.input :total_price
      f.input :status
      f.input :gst_amount
      f.input :pst_amount
      f.input :hst_amount
      f.input :qst_amount
      f.input :total_tax_amount
      f.input :total_price_with_tax
      f.input :order_date
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :customer
    column :cart
    column :status
    column :total_price
    column :gst_amount
    column :pst_amount
    column :hst_amount
    column :qst_amount
    column :total_tax_amount
    column :total_price_with_tax
    column :order_date
    actions
  end
end
