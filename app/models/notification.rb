class Notification < ApplicationRecord
	belongs_to :user, class_name: 'User'
	belongs_to :owner, class_name: 'User'
	belongs_to :question
	scope :card_notifications, -> (owner_id) { where("owner_id = ? ", owner_id) }
	scope :number_notifications, -> (owner_id) { where("owner_id = ? AND state = ?", owner_id, false) }
end
