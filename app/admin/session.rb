ActiveAdmin.register Session do
	permit_params :title

	show do
	  attributes_table do
	   	row :title
	   	row :cards do |session|
	    	session.takes.count
	    end
	  	row :created_at
	  end
	  active_admin_comments
	end

	index do
		selectable_column
		column :title
		column "Cards" do |session|
  			session.takes.count
		end
		column :created_at
		actions defaults: false do |session|
    		link_to 'View', admin_session_path(session), class: 'button'
  		end
	end

	filter :title
	filter :created_at
end
