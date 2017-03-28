class Question < ApplicationRecord
	belongs_to :user
	has_many :answers

	accepts_nested_attributes_for :answers, reject_if: proc { |attributes| attributes['answer_markdown'].blank? }, allow_destroy: true

	validates :title, :description_markdown, :explanation_markdown, presence: true
end
