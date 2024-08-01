ActiveAdmin.register Customer do
  permit_params :name, :email, :password, :password_confirmation, :address, :province

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :province
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :email
  filter :address
  filter :province
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :address
      f.input :province
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :address
      row :province
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
