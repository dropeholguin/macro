class AddTimeAtToStatsSessions < ActiveRecord::Migration[5.0]
  def change
  	add_column :stats_sessions, :time_at, :datetime
  end
end
