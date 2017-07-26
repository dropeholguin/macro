class VoteReason < ApplicationRecord
  validates :user_id, uniqueness: { scope: :question_id, message: "You have already voted." }
  belongs_to :user
  belongs_to :question
end
