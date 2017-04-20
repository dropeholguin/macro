class Question < ApplicationRecord
	include Tire::Model::Search
  	include Tire::Model::Callbacks
  	ac_field :title
  	acts_as_taggable
  	acts_as_taggable_on :tags
	belongs_to :user
	has_many :answers, inverse_of: :question
	has_many :cards

	accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
	validates :title, :description_markdown, :explanation_markdown, presence: true
	has_reputation :votes, source: :user, aggregated_by: :sum

	enum tags: ["SAS Programming", "SAS Macro", "DI Studio", "SAS Management Console", "Enterprise Guide", "Workspace Management"]

	index_name("questions")
	mapping do
	    indexes :id, index: :not_analyzed
	    indexes :description_markdown, analyzer: 'snowball'
	    indexes :create_at, type: 'date'
	    indexes :tag_list, type: 'string', analyzer: 'keyword'
	end

	def self.search(params)
		tire.search(load: true) do
			query { string params[:query] } if params[:query].present?

			filter :terms, tag_list: [params[:the_tag]] if params[:the_tag].present?
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

	def self.to_csv(options = {})
	  desired_columns = ["id", "title", "description_markdown", "explanation_markdown"]
	  CSV.generate(options) do |csv|
	    csv << desired_columns
	    all.each do |question|
	      csv << question.attributes.values_at(*desired_columns)
	    end
	  end
	end

	def self.import(file)
		spreadsheet = Roo::Spreadsheet.open(file.path)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			product = find_by(id: row["id"]) || new
			product.attributes = row.to_hash
			product.save!
		end
	end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when ".csv" then Roo::CSV.new(file.path, nil, :ignore)
	  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
	  else raise "Unknown file type: #{file.original_filename}"
	  end
	end
end
