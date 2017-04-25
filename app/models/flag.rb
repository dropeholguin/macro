class Flag < ApplicationRecord
	belongs_to :user
	belongs_to :question

	validates :reason, presence: true
end
