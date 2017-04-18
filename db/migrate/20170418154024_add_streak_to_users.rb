class AddStreakToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :streak, :integer, default: 0
  end
end
