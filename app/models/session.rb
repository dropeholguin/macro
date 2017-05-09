class Session < ApplicationRecord
	belongs_to :user
	has_many :takes
	validates :title, presence: true
end
