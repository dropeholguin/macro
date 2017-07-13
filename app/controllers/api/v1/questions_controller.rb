class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_user!
	before_action :tokens
	load_and_authorize_resource

	include ApplicationHelper
	include ActionView::Helpers::DateHelper
	include ActionView::Helpers::TextHelper
	
	# GET /cards
	def index
		render json: @questions
	end

	# GET /cards/:id
	def show
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

	# PUT /cards/:id/verify
	def verify
		comments = @question.comments.order("created_at desc")
		state    = @question.evaluators_for(:votes).include?(current_user)
		votes    = @question.reputation_for(:votes).to_i

		result = @question.verify?(
								answer_ids: params[:answerIds], 
								answer_text: params[:answerText],
								card_time: cookies[:time],
								user_id: current_user.id
							)
		cookies.delete(:time)

		# total_answers_count   = Card.question_cards(@question.id).select(:user_id).distinct.count
		# correct_answers_count = Card.questions_right(@question.id).select(:user_id).distinct.count
		# percentage_people     = ((correct_answers_count.to_f / total_answers_count) * 100).round(2)

		answers = @question.answers.select(:id, :is_correct)

		render json: {
			answers: answers,
			comments: comments,
			is_passed: result[:is_passed],
			state: state,
			streak: current_user.streak,
			time: result[:new_card_time],
			time_long: result[:time_long],
			votes: votes
		}
	end

	def delete
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

	def verify_card
		user 	= current_user
		answers = params[:answerIds]
		card 	= Question.find params[:id]
		tokens_earned = 0
	
		if card.deleting?
			render status: 404, json: {
				errors: "Question not found"
			}	
		elsif card.present?
			votes = card.reputation_for(:votes).to_i

			if card.choice == "user input"
				is_passed = card.answers.first.answer_markdown.eql? params[:answerText]
			else
				answers_correct = card.answers.select { |answer| answer.is_correct == true }
				is_passed 		= answers_correct.map(&:id) == answers.map(&:to_i)
			end
			if is_passed == true
				user.update_attributes(streak: user.streak + 1)
				if user.streak < 9 && user.streak >= 5
					user.update_attributes(points: user.points + @one_token)
					tokens_earned 	= @one_token
					notification 	= Notification.new(owner: card.user, user: current_user, question: card, message: "You've earned +1 tokens", category: "tokens_positive", source: "#{question_path(card)}")
					notification.save
				elsif user.streak >= 9
					user.update_attributes(points: user.points + @two_token)
					tokens_earned	= @two_token
					notification 	= Notification.new(owner: card.user, user: current_user, question: card, message: "You've earned +2 tokens", category: "tokens_positive", source: "#{question_path(card)}")
					notification.save
				end
			else
				user.update_attributes(streak: 0)
			end
			@card = Card.new(user_id: user.id, question_id: card.id, is_passed: is_passed)
			@card.save

			render status: 200, json: {
				message: "Successful operation",
				result: is_passed,
				explanationText: card.explanation_markdown,
				voteResultPrevious: votes,
				voteLock: 0,
				tokensEarned: tokens_earned
			}
		else
			render status: 400, json: {
				errors: "Invalid ID supplied"
			}		
		end
	end

	def vote
		value = params[:type] == "up" ? 1 : -1
		reason = params[:reason] || "Default Reason"
		@question = Question.find(params[:id])
		author = @question.user

		if value == 1
			message = "+#{value} #{current_user.name} has voted his card"
		else
			message = "#{value} #{current_user.name} has voted his card"
		end

		if author != current_user
			@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: message, category: "vote", source: "#{question_path(@question)}")
			@notification.save
			@question.add_or_update_evaluation(:votes, value, current_user)
			if (value == -1)
				VoteReason.create(question_id: @question.id, user_id: current_user.id, reason: reason)
			end

			if @question.reputation_for(:votes).to_i == 4
				author.update_attributes(points: author.points + 32)
			end
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
