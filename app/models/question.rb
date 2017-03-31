class Question < ApplicationRecord
	include Tire::Model::Search
  	include Tire::Model::Callbacks
  	acts_as_taggable
	belongs_to :user
	has_many :answers, inverse_of: :question

	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

	validates :title, :description_markdown, :explanation_markdown, presence: true

	mapping do
	    indexes :id, index: :not_analyzed
	    indexes :title, analyzer: 'snowball', boost: 100
	    indexes :description_markdown, analyzer: 'snowball'
	    indexes :create_at, type: 'date'
	end

	def self.search(params)
	  tire.search(load: true) do
	    query { string params[:query] } if params[:query].present?

	    sort do
	  		by :create_at, :desc
		end
	  end
	end
end
