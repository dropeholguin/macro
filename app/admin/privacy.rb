ActiveAdmin.register Privacy do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :body, :category, :version

	form do |f|
	    f.inputs 'Details' do
	      f.input :category, as: :select, include_blank: false
	      f.input :version
	      f.input :body, as: :html_editor
	    end
	    f.actions
  	end

  	show do
	  attributes_table do
	    row :category
	    row :version
	    row :body
	    row :created_at
	  end
	  active_admin_comments
	end

	index do
		selectable_column
		column :category
		column :version
		column :body
		column "Create Date", :created_at
		actions defaults: false do |privacy|
	    	link_to 'View', admin_privacy_path(privacy)
		end
		actions defaults: false do |privacy|
			link_to "Edit", edit_admin_privacy_path(privacy)
		end
	end

	filter :category
	filter :version
	filter :created_at
end

