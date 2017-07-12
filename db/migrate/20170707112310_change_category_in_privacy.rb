class ChangeCategoryInPrivacy < ActiveRecord::Migration[5.0]
  def change
    remove_column :privacies, :category, :string
    add_column :privacies, :category, :integer
  end
end
