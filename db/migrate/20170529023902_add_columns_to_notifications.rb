class AddColumnsToNotifications < ActiveRecord::Migration[5.0]
  def change
  	add_column :notifications, :state, :boolean, default: false
  	add_column :notifications, :category, :string
  	add_column :notifications, :source, :string
  end
end
