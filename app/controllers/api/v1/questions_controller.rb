class Api::V1::QuestionsController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
		render json: Question.all
	end

	def create
		card = Question.new(card_params)
		card.user = User.find_by_email(params[:email])

		if card.save
			render status: 200, json: {
				message: "Successfully created Card.",
				card: card
			}.to_json
		else
			render status: 422, json: {
				errors: card.errors
			}.to_json
		end
	end

	def update
		card = Question.find(params[:id])
		if card.update(card_params)
			render status: 200, json: {
				message: "Successfully updated Card.",
				Card: card
			}.to_json
		else
			render status: 422, json: {
				errors: card.errors
			}.to_json
		end
	end

	def count_cards
		user = User.find_by_email(params[:email])

		if params[:query].present? || params[:the_tag].present?
			questions = Question.search(params)
			questions_sort = []

			cards = Card.number_cards_submitted(user.id).pluck(:question_id)
			questions.each do |question|
				if !cards.include?(question.id)
					questions_sort << question
				end
			end
			number_questions = questions_sort.count
			render status: 200, json: {
				message: "Available Cards",
				countCards: number_questions
			}.to_json
		else
			render status: 400, json: {
				errors: "Invalid tag value"
			}.to_json
	    end
	end

	private
	def card_params
		params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
	end
end
