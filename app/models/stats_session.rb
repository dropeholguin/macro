class StatsSession < ApplicationRecord
	belongs_to :user
	belongs_to :session
	scope :peoples_session, -> (session_id) { where("session_id = ?", session_id) }
	scope :stats_sessions, -> (session_id) { where("session_id = ? AND is_passed = ?", session_id, true) }
end
