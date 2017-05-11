class SessionCard < ApplicationRecord
	belongs_to :user
	belongs_to :question
	belongs_to :session
end
