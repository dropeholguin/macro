class CreateAcceptedPrivacies < ActiveRecord::Migration[5.0]
  def change
    create_table :accepted_privacies do |t|
      t.references :user, foreign_key: true
      t.references :privacy, foreign_key: true

      t.timestamps
    end
  end
end
