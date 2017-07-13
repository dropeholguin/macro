class CreateVoteReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :vote_reasons do |t|
      t.string :reason
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
