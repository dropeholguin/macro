class CreateTakes < ActiveRecord::Migration[5.0]
  def change
    create_table :takes do |t|
    	t.references :session, index: true
    	t.references :question, index: true
    	t.timestamps
    end
  end
end
