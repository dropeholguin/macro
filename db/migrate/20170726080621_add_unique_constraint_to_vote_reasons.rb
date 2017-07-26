class AddUniqueConstraintToVoteReasons < ActiveRecord::Migration[5.0]
  def change
    remove_index :vote_reasons, :question_id
    remove_index :vote_reasons, :user_id
    
    add_index :vote_reasons, [:question_id, :user_id], :unique => true
  end
end
