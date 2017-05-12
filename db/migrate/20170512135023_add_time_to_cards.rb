class AddTimeToCards < ActiveRecord::Migration[5.0]
  def change
  	add_column :cards, :time_at, :datetime
  end
end
