class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment_markdown
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
