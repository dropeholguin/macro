class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_user!
	before_action :tokens
	load_and_authorize_resource

	include ApplicationHelper
	include ActionView::Helpers::DateHelper
	include ActionView::Helpers::TextHelper
	
	# GET /cards
	def index
		render json: { questions: @questions }
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
		user = current_user
		if user.present? && user.valid?
			tags = ""
			if params[:tags_all].present?
		        params[:tags_all].each do |id_tag|
		            tag = Topic.find(id_tag.to_i)
		            tags = tags + tag.name + " "
		            params[:tags_all] = tags
		        end
			elsif params[:tags_any].present?
				params[:tags_any].each do |id_tag|
		            tag = Topic.find(id_tag.to_i)
		            tags = tags + tag.name + " "
		            params[:tags_any] = tags
		        end
			end
			
			if params[:tags_all].present? || params[:tags_any].present?
				questions = Question.search(params)
				questions_sort = []

				cards = Card.number_cards_submitted(user.id).pluck(:question_id)
				questions.each do |card|
					if !cards.include?(card.id) && card.activated?
						questions_sort << card
					end
				end
				number_questions = questions_sort.count

				if number_questions == 0
					Question.all.each do |card|
						if !cards.include?(card.id) && card.activated?
							questions_sort << card
						end
					end
					number_questions = questions_sort.count
				end
				render status: 200, json: {
					message: "Available Cards",
					tagCount: number_questions
				}
			else
				render status: 400, json: {
					errors: "Invalid tag value"
				}
		    end
		else
			render status: 400, json: {
				errors: "Invalid user"
			}
		end
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
			votes    = card.reputation_for(:votes).to_i
			result = card.verify?(
								answer_ids: params[:answerIds], 
								answer_text: params[:answerText],
								user_id: current_user.id
							)

			render status: 200, json: {
				message: "Successful operation",
				result: result[:is_passed],
				answerIds: params[:answerIds],
				answerText: params[:answerText],
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
		card = Question.find_by(id: params[:id])

		if card.deleting?
			render status: 404, json: {
				errors: "Question not found"
			}
		elsif card.present?
			card.delete!
			render status: 200, json: {
				message: "Success",
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
		question_ids_array = cookies[:cards].split("-")
		question_id = question_ids_array.shift
		question_array_string = question_ids_array.join("-")
		cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }
		cookies[:time] = { value: Time.now, expires: 1.hours.from_now }

		@question = Question.find question_id.to_i
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

		def card_params
			params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
