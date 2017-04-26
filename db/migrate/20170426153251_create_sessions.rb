class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
    	t.string :title
    	t.integer :score
    	t.references :user, index: true
    	t.timestamps
    end
  end
end
