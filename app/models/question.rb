class Question < ApplicationRecord
	include Tire::Model::Search
  	include Tire::Model::Callbacks
  	ac_field :title
  	acts_as_taggable
  	acts_as_taggable_on :tags
	belongs_to :user
	has_many :takes
	has_many :answers, inverse_of: :question
	has_many :cards
	has_many :session_cards
	has_many :comments
	has_many :flags, dependent: :destroy
	has_many :notifications
	
	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
	validates :description_markdown, :explanation_markdown, presence: true
	has_reputation :votes, source: :user, aggregated_by: :sum

	enum tags: ["SAS Programming", "SAS Macro", "DI Studio", "SAS Management Console", "Enterprise Guide", "Workspace Management"]

	scope :questions_list, -> (user_id) { where(user_id: user_id) }

	index_name("questions")
	mapping do
	    indexes :id, index: :not_analyzed
	    indexes :description_markdown, analyzer: 'snowball'
	    indexes :create_at, type: 'date'
	    indexes :tag_list, type: 'string', analyzer: 'keyword'
	end

	def self.search(params)
		tire.search(load: true) do
			query do
				boolean do
					must { string params[:query] } if params[:query].present?
					must { string params[:tags_all], default_operator: 'AND'} if params[:tags_all].present?
					must { string params[:tags_any], default_operator: 'OR'} if params[:tags_any].present?
					must { terms :tag_list, [params[:the_tag]]} if params[:the_tag].present?
				end
			end
			sort do
				by :create_at, :desc
			end
		end
	end

	def to_indexed_json
    	to_json(methods: [:tag_list, :title])
  	end

  	def list_tag
	  tags.map(&:name)
	end
end
