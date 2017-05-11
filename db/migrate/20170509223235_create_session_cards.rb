class CreateSessionCards < ActiveRecord::Migration[5.0]
  def change
    create_table :session_cards do |t|
    	t.references :user
		t.references :question
		t.references :session
		t.boolean :is_passed
      	t.timestamps
    end
  end
end
