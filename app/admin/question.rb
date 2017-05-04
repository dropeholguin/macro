ActiveAdmin.register Question do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
active_admin_import validate: true,
            template_object: ActiveAdminImport::Model.new(
                hint: "file will be imported with such header format: 'title','description_markdown', 'explanation_markdown', 'choice'",
                csv_headers: ["title","description_markdown","explanation_markdown", "choice"]
            )

permit_params :title, :user_id, :description_markdown, :explanation_markdown, :choice

csv do
	column :id
	column :title
	column :description_markdown
	column :explanation_markdown
    column :choice
    column :created_at
end

show do
  attributes_table do
 	row :user
 	row :title
	row :description_markdown
	row :explanation_markdown
    row :choice
    row :created_at
  end
  active_admin_comments
end

index do
	selectable_column
	id_column
	column :user
	column :title
	column :description_markdown
	column :explanation_markdown
	column "Create Date", :created_at
	column :choice
	actions defaults: false do |question|
    	link_to 'View', admin_question_path(question), class: 'button'
  	end
  	actions defaults: false do |question|
    	link_to 'Edit', edit_admin_question_path(question), class: 'button'
  	end
end

filter :title
filter :created_at
end
