class Privacy < ApplicationRecord
	validates :type, :body, :version, presence: true
end
