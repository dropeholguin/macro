class Question < ApplicationRecord
	belongs_to :user
	has_many :answers

	validates :title, :description_markdown, :explanation_markdown, presence: true
end
