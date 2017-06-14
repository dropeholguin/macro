class FixColumnNameTypeToPrivacies < ActiveRecord::Migration[5.0]
  def change
  	rename_column :privacies, :type, :category
  end
end
