ActiveAdmin.register Answer do

	active_admin_import validate: true,
	            template_object: ActiveAdminImport::Model.new(
	                hint: "file will be imported with such header format: 'Id','question Id','Is correct', 'answer_markdown'",
	                csv_headers: ["id","question_id","is_correct","answer_markdown"]
	            )

	permit_params :question_id, :is_correct, :answer_markdown

	csv column_names: false do
		column :id
		column :question_id
		column :is_correct
		column :answer_markdown
	end

	show do
	  attributes_table do
	 	row :question
	 	row :is_correct
		row :answer_markdown
		row :created_at
	  end
	  active_admin_comments
	end

	index do
		selectable_column
		id_column
		column :question
		column :is_correct
		column :answer_markdown
		column "Create Date", :created_at
		actions defaults: false do |answer|
	    	link_to 'View', admin_answer_path(answer), class: 'button'
	  	end
	end
	filter :question
	filter :is_correct
	filter :answer_markdown
	filter :created_at
end
