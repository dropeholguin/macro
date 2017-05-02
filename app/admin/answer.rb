ActiveAdmin.register Answer do
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
permit_params :question_id, :is_correct, :answer_markdown
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
