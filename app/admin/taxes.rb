# app/admin/taxes.rb
ActiveAdmin.register Tax do
  permit_params :province, :gst_rate, :pst_rate, :hst_rate, :qst_rate

  index do
    selectable_column
    id_column
    column :province
    column :gst_rate
    column :pst_rate
    column :hst_rate
    column :qst_rate
    column :created_at
    column :updated_at
    actions
  end

  filter :province
  filter :gst_rate
  filter :pst_rate
  filter :hst_rate
  filter :qst_rate
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :province
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
      f.input :qst_rate
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :province
      row :gst_rate
      row :pst_rate
      row :hst_rate
      row :qst_rate
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
