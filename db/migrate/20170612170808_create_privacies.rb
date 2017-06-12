class CreatePrivacies < ActiveRecord::Migration[5.0]
  def change
    create_table :privacies do |t|
    	t.string :type
    	t.text :body
    	t.string :version
     	t.timestamps
    end
  end
end
