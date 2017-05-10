class Session < ApplicationRecord
	belongs_to :user
	has_many :takes
	has_many :session_cards

	validates :title, presence: true
end
