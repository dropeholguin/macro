class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :description_markdown
      t.text :explanation_markdown

      t.timestamps
    end
  end
end
