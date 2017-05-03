ActiveAdmin.register Flag do
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
permit_params :reason, :user_id, :question_id

show do
  attributes_table do
    row :reason
    row :user
    row :question
    row :created_at
  end
  active_admin_comments
end

index do
	selectable_column
	column :reason
	column "Create Date", :created_at
	column "Question" do |flag|
  		link_to(flag.question.title, admin_question_path(flag.question))
	end
	actions defaults: false do |flag|
    	link_to 'View', admin_flag_path(flag), class: 'button'
	end
	actions defaults: false do |flag|
		link_to "Delete", admin_flag_path(flag), method: :delete, data: { confirm: "Are you sure?" }, class: 'button'
	end
end

filter :question
filter :user
filter :reason
filter :created_at

end
