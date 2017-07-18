ActiveAdmin.register Reason do
  permit_params :text

  show do
    attributes_table do
      row :id
      row :text
      row :created_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    column :text
    column :created_at
    actions defaults: false do |reason|
      link_to 'View', admin_reason_path(reason), class: 'button'
    end
  end
end
