class RemovePrivacyAcceptanceRelations < ActiveRecord::Migration[5.0]
  def change
    drop_table :accepted_privacies

    remove_column :users, :privacy_version
  end
end
