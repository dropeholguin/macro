class CreateStatsSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :stats_sessions do |t|
    	t.references :user
		t.references :session
		t.float :percentage
		t.boolean :is_passed
    	t.timestamps
    end
  end
end
