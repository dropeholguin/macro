class Card < ApplicationRecord
	belongs_to :user
	belongs_to :question
    scope :question_cards, -> (question_id) { where("question_id = ?", question_id) }
    scope :questions_right, -> (question_id) { where("question_id = ? AND is_passed = ?", question_id, true) }
end
