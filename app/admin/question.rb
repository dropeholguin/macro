ActiveAdmin.register Question do

  active_admin_import validate: true,
              template_object: ActiveAdminImport::Model.new(
                  hint: "file will be imported with such header format: 'id',title','description_markdown', 'explanation_markdown', 'choice'",
                  csv_headers: ["id","title","description_markdown","explanation_markdown", "choice"]
              ),
              after_batch_import: ->(importer) {
                questions = Question.find importer.values_at('id')
                questions.each do |question|
                  question.update_attributes user_id: 1
                end
                
              }

  permit_params :title, :user_id, :description_markdown, :explanation_markdown, :choice

  csv column_names: false do
  	column :id
  	column :title
  	column :description_markdown
  	column :explanation_markdown
    column :choice
  end
  action_item only: :show  do
    if question.suspended == false
      link_to 'Suspend Question', suspend_path(question), method: :patch, class: 'button'
    else
      link_to 'Approve Question', approve_path(question), method: :patch, class: 'button'
    end
  end
  show do
    attributes_table do
     	row :user
     	row :title
    	row :description_markdown
    	row :explanation_markdown
      row :choice
      row :created_at
      row :suspended
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
    column :suspended
    column "" do |question|
      if question.suspended == false
        link_to 'Suspend Question', suspend_path(question), method: :patch, class: 'button'
      else
        link_to 'Active Question', approve_path(question), method: :patch, class: 'button'
      end
    end
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
