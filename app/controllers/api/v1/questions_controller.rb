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

	private
	def card_params
		params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
	end
end
