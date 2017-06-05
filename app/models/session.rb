class Session < ApplicationRecord
	include Tire::Model::Search
  	include Tire::Model::Callbacks
	belongs_to :user
	has_many :takes
	has_many :session_cards
	has_many :stats_sessions

	validates :title, presence: true

	mapping do
	    indexes :id, index: :not_analyzed
	    indexes :title, analyzer: 'snowball'
	    indexes :create_at, type: 'date'
	    indexes :tag, analyzer: 'keyword'
	end

	def self.search(params)
		tire.search(load: true) do
			query { string params[:query] } if params[:query].present?
				
			sort do
				by :create_at, :desc
			end
		end
	end

	def to_indexed_json
    	to_json(methods: [:tag, :title])
  	end
end
