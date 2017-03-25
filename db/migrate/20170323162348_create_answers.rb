class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.boolean :is_correct
      t.text :answer_markdown
      t.timestamps
    end
  end
end
