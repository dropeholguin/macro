class Privacy < ApplicationRecord
	validates :category, :body, :version, presence: true

  enum category: [:privacy_policy, :terms_and_conditions]
end
