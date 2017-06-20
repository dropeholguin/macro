class AddPrivacyVersionToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :privacy_version, :string
  end
end
