class Api::V1::QuestionsController < ApplicationController
	before_action :authenticate_user!
	include ApplicationHelper
	include ActionView::Helpers::DateHelper
	include ActionView::Helpers::TextHelper
	
	def index
		render json: Question.all
	end

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
			}.to_json
		else
			render status: 405, json: {
				errors: "Invalid input"
			}.to_json
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
				}.to_json
			else
				render status: 405, json: {
					errors: card.errors
				}.to_json
			end
		else
			render status: 405, json: {
				errors: "Invalid input"
			}.to_json
		end
	end

	def update
		card = Question.find(params[:id])
		if card.activated?
			if card.update(card_params)
				render status: 200, json: {
					message: "Successfully updated Card.",
					Card: card
				}.to_json
			else
				render status: 405, json: {
					errors: card.errors
				}.to_json
			end
		else
			render status: 405, json: {
				errors: "Invalid input"
			}.to_json
		end
	end

	def count_cards
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
				}.to_json
			else
				render status: 400, json: {
					errors: "Invalid tag value"
				}.to_json
		    end
		else
			render status: 400, json: {
				errors: "Invalid user"
			}.to_json
		end
	end

	def delete
		card = Question.find(params[:id])

		if card.deleting?
			render status: 404, json: {
				errors: "Question not found"
			}.to_json	
		elsif card.present?
			card.delete!
			render status: 200, json: {
				message: "Success",
			}.to_json
		else
			render status: 400, json: {
				errors: "Invalid ID supplied"
			}.to_json			
		end
	end

	private
	def card_params
		params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
	end
end
