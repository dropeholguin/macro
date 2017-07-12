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

  def verify? args
    answer_ids  = args[:answer_ids]
    answer_text = args[:answer_text]
    user_id     = args[:user_id]

    time = Time.now.to_i - DateTime.parse(args[:card_time]).to_i
    card_time = Time.at(time).to_datetime

    result = {
      is_passed: false,
      time_long: true,
      new_card_time: ''
    }

    if card_time < CARD_TIME
      if self.choice == 'user input'
        result[:is_passed] = self.answers.first.answer_markdown.eql? answer_text
      else
        correct_answers_ids = self.answers.where(is_correct: true).map(&:id)
        result[:is_passed] = correct_answers_ids.sort == answer_ids.map(&:to_i).sort 
      end
    else
      result[:time_long] = false
    end

    user = User.find_by(id: user_id)
    if result[:is_passed]
      user.increment!(:streak, 1)
      if user.streak >= 5 && user.streak < 9
        user.increment!(:points, 1)
        notification = Notification.new(owner: self.user, user: user, question: self, message: "You've earned +1 tokens", category: "tokens_positive", source: "#{Rails.application.routes.url_helpers.question_path(self.id)}")
        notification.save
      elsif user.streak >= 9
        user.increment!(:points, 2)
        notification = Notification.new(owner: self.user, user: user, question: self, message: "You've earned +2 tokens", category: "tokens_positive", source: "#{Rails.application.routes.url_helpers.question_path(self.id)}")
        notification.save
      end
    else
      user.update(streak: 0)
    end

    new_card = Card.new(user_id: user.id, question_id: self.id, is_passed: result[:is_passed], time_at: card_time)
    new_card.save
    result[:new_card_time] = new_card.time_at.strftime("%M:%S")
    result
  end
end
