class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
		t.references :question
		t.boolean :is_correct
		t.text :answer_markdown
		t.timestamps
    end
  end
end
