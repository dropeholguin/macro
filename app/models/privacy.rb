class Privacy < ApplicationRecord
	validates :category, :body, :version, presence: true
end
