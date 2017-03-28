class AddChoiceToQuestions < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :choice, :string
  end
end
