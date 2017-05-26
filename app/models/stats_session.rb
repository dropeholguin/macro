class StatsSession < ApplicationRecord
	belongs_to :user
	belongs_to :session
	scope :peoples_session, -> (session_id) { where("session_id = ?", session_id) }
	scope :stats_sessions, -> (session_id) { where("session_id = ? AND is_passed = ?", session_id, true) }
	scope :stats_session, -> (session_id, user_id){ where("session_id = ? AND user_id = ?", session_id, user_id)}
end 
