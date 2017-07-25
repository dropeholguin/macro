class Take < ApplicationRecord
	belongs_to :question
	belongs_to :session
	scope :session_takes, -> (session_id) { where("session_id = ?", session_id ) }
end
