class RenameReasonToVoteReasonId < ActiveRecord::Migration[5.0]
  def change
    remove_column :vote_reasons, :reason, :string
    add_column :vote_reasons, :vote_reason_id, :integer
  end
end
