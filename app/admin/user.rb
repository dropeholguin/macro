ActiveAdmin.register User do
	permit_params :name, :email, :password, :password_confirmation

	show do
	  attributes_table do
	   	row :name
	   	row :email
	  	row :created_at
	  	row :points
	  end
	  active_admin_comments
	end

	index do
		selectable_column
		column :name
		column :email
		column :created_at
		actions defaults: false do |user|
    		link_to 'View', admin_user_path(user), class: 'button'
  		end
	end

	filter :name
	filter :email
	filter :created_at
end
