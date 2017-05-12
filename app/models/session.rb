class Session < ApplicationRecord
	belongs_to :user
	has_many :takes
	has_many :session_cards
	has_many :stats_sessions

	validates :title, presence: true
end
