class AddSuspendedToQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :suspended, :boolean, default: false
  end
end
