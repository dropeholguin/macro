class CreateFlags < ActiveRecord::Migration[5.0]
  def change
    create_table :flags do |t|
    	t.text :reason
		t.references :user, index: true
		t.references :question, index: true
    	t.timestamps
    end
  end
end
