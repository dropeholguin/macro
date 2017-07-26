class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_user!
	before_action :tokens
	load_and_authorize_resource

	before_action :question_query_params, only: [:count, :next_card]

	include ApplicationHelper
	include ActionView::Helpers::DateHelper
	include ActionView::Helpers::TextHelper
	
	# GET /cards
	def index
		render json: @questions
	end

	# GET /cards/:id/statistics
	def statistics
		card = Card.find_by(question: @question, user: current_user)

		if card.present?	# if current user has already answered the question or not.

			times_taken = @question.cards.count
			num_of_correctly_answered = @question.cards.where(is_passed: true).count
			percent_correct = num_of_correctly_answered / times_taken * 100

			render status: 200, json: {
				author_username: @question.user.name,
				author_id: @question.user.id,
				times_taken: times_taken,
				percent_correct: percent_correct,
				average_time: "N/A", # pending todo
				total_votes: @question.reputation_for(:votes).to_i,
				create_date: @question.created_at,
				edit_date: @question.updated_at,
				editor_id: "string",	# pending due to MC-174
				editor_username: "Editor"	#pending due to MC-174
			}
		else 
			render status: 405, json: {
				errors: "User has not answered the question"
			}
		end
	end

	# GET /cards/:id
	def edit
		card = Question.where(id: params[:id]).select(:id, :state).take 
		
		if card.present? && card.activated?
			card = Question.where(id: card.id).select(:id, :choice, :description_markdown, :explanation_markdown).take 
			answers = card.answers.map{ |answer| {answerText: answer.answer_markdown, isCorrect: answer.is_correct }}
			tags = card.tags.map(&:id)

			render status: 200, json: {
				Card: card,
				answers: answers,
				tags: tags
			}
		else
			render status: 405, json: {
				errors: "Invalid input"
			}
		end
	end

	# POST /cards
	def create
		card = Question.new(card_params)
		card.user = current_user
		card.title = truncate(strip_tags(markdown(card.description_markdown)), length: 15)
		tags = []
		if params[:tags].present?
	        params[:tags].each do |id_tag|
	            tag = Topic.find(id_tag.to_i)
	            tags << tag.name
	        end
	    end
		card.tag_list = tags

		if params[:answers].present?
			params[:answers].each do |answer_attributes|
	            answer = card.answers.new(answer_markdown: answer_attributes[:answer_markdown], is_correct: answer_attributes[:is_correct])
	            answer.save
	        end
		end
		if !params[:tags].empty?
			if card.save
				render status: 200, json: {
					message: "Successfully created Card.",
					card: card
				}
			else
				render status: 405, json: {
					errors: card.errors
				}
			end
		else
			render status: 405, json: {
				errors: "Invalid input"
			}
		end
	end

	# PUT cards/:id
	def update
		card = Question.find(params[:id])
		if card.activated?
			if card.update(card_params)
				render status: 200, json: {
					message: "Successfully updated Card.",
					Card: card
				}
			else
				render status: 405, json: {
					errors: card.errors
				}
			end
		else
			render status: 405, json: {
				errors: "Invalid input"
			}
		end
	end

	# GET /cards/count
	def count
		render status: 200, json: {
			count: @unanswered_questions.count
		}
	end

	# def verify
	# 	comments = @question.comments.order("created_at desc")
	# 	state    = @question.evaluators_for(:votes).include?(current_user)
	# 	votes    = @question.reputation_for(:votes).to_i

	# 	result = @question.verify?(
	# 							answer_ids: params[:answerIds], 
	# 							answer_text: params[:answerText],
	# 							card_time: cookies[:time],
	# 							user_id: current_user.id
	# 						)
	# 	cookies.delete(:time)

	# 	# total_answers_count   = Card.question_cards(@question.id).select(:user_id).distinct.count
	# 	# correct_answers_count = Card.questions_right(@question.id).select(:user_id).distinct.count
	# 	# percentage_people     = ((correct_answers_count.to_f / total_answers_count) * 100).round(2)

	# 	answers = @question.answers.select(:id, :is_correct)

	# 	render json: {
	# 		answers: answers,
	# 		comments: comments,
	# 		is_passed: result[:is_passed],
	# 		state: state,
	# 		streak: current_user.streak,
	# 		time: result[:new_card_time],
	# 		time_long: result[:time_long],
	# 		votes: votes
	# 	}
	# end


	# PUT /cards/:id/verify
	def verify
		card = Question.find params[:id]	
		if card.deleting?
			render status: 404, json: {
				errors: "Question not found"
			}
		elsif card.present?
			votes  = card.reputation_for(:votes).to_i
			result = card.verify?(
								answer_ids: params[:answerIds], 
								answer_text: params[:answerText],
								user_id: current_user.id
							)

			answerIds  = []
			answerText = ''
			if card.choice == 'user input'
				answerText = card.answers.first.answer_markdown
			else
				answerIds  = card.answers.where(is_correct: true).select(:id).collect(&:id)
			end

			render status: 200, json: {
				message: "Successful operation",
				result: result[:is_passed],
				answerIds: answerIds,
				answerText: answerText,
				explanationText: card.explanation_markdown,
				voteResultPrevious: votes,
				voteLock: 0,
				tokensEarned: result[:tokensEarned]
			}
		else
			render status: 400, json: {
				errors: "Invalid ID supplied"
			}		
		end
	end

	# DELETE /cards/:id
	def destroy
		card = Question.find(params[:id])

		if card.deleting?
			render status: 404, json: {
				errors: "Question not found"
			}
		elsif card.present?
			card.delete!
			render status: 200, json: {
				message: "Success",
			}
		else
			render status: 400, json: {
				errors: "Invalid ID supplied"
			}		
		end
	end

	def vote
		value = params[:vote_direction] == "up" ? 1 : -1
		reason_id = params[:vote_reason_id] || "Default Reason"
		@question = Question.find(params[:id])
		author = @question.user

		if value == 1
			message = "Your card #{@question.title} received an upvote"
		else
			message = "Your card #{@question.title} received a downvote"
		end

		if author != current_user
			@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: message, category: "vote", source: "#{question_path(@question)}")
			@notification.save
			@question.add_or_update_evaluation(:votes, value, current_user)
			if (value == -1)
				VoteReason.create(question_id: @question.id, user_id: current_user.id, vote_reason_id: reason_id)
			end

			if @question.reputation_for(:votes).to_i == 4
				author.update_attributes(points: author.points + 32)
			end
		end
	end

	def next_card
		@question    = @unanswered_questions.first
		@description = markdown(@question.description_markdown)
		@explanation = markdown(@question.explanation_markdown)
		@answers = @question.answers.select(:id, :answer_markdown)

		respond_to do |format|
		  format.json  { render json: { question: @question, answers: @answers, tag_list: @question.tag_list, description: @description, explanation: @explanation } }
		end
	end
	private
		def tokens
			@one_token = 1
			@two_token = 2
		end

    def question_query_params
      filter_type = {}
      filter_type[:any]       = true # default operator
      filter_type[:match_all] = true if params[:tags_all]
      filter_type[:exclude]   = true if params[:tags_not] # precedent operator over any & all

      tag_ids   = params[:tags_not] || params[:tags_any] || params[:tags_all]
      tag_names = Topic.where(id: tag_ids).collect(&:name)

      # TODO: randomize cards ?
      @unanswered_questions = Question.activated.tagged_with(tag_names, filter_type)
                                     .where.not(id: Card.where(user_id: current_user.id).select(:question_id))
    end

		def card_params
			params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
