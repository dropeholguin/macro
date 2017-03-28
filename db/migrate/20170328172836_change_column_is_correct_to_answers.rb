class ChangeColumnIsCorrectToAnswers < ActiveRecord::Migration[5.0]
  def change
  	change_column :answers, :is_correct, :boolean, default: false
  end
end
