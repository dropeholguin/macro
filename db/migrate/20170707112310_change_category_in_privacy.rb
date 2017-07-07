class ChangeCategoryInPrivacy < ActiveRecord::Migration[5.0]
  def change
    change_column :privacies, :category, 'integer USING CAST(category AS integer)', null: false
  end
end
