class AddCountFlagsToQuestions < ActiveRecord::Migration[5.0]
  def change
  	add_column :questions, :count_flags, :integer, default: 0
  end
end
