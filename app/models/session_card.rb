class SessionCard < ApplicationRecord
	belongs_to :user
	belongs_to :question
	belongs_to :session
	scope :session_cards_correct, -> (session_id, user_id) { where("session_id = ? AND user_id = ? AND is_passed = ?", session_id, user_id, true ) }
end
