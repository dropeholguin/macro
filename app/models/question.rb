class Question < ApplicationRecord
	belongs_to :user
	has_many :answers, inverse_of: :question

	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

	validates :title, :description_markdown, :explanation_markdown, presence: true
end
