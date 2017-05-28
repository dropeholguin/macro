class AddNumberCardsCorrectToStatsSessions < ActiveRecord::Migration[5.0]
  def change
  	add_column :stats_sessions, :number_cards_correct, :integer, default: 0
  end
end
