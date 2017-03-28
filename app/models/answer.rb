class Answer < ApplicationRecord
	belongs_to :question
	validates :answer_markdown, presence: true
end
