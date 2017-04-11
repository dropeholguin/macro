class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references :user
      t.references :question
      t.boolean :is_passed

      t.timestamps
    end
  end
end
