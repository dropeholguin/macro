class Api::V1::TagsController < ApplicationController
	def index
		tags = Tag.all
		if tags.present?
			render json: tags
		else
			render status: 404, json: {
					Description: "No tags found"
			}.to_json
		end 
	end
	
	def update
		if  ((Integer(params[:id]) rescue false)&&params[:tag].present?)
			tag = Tag.where(:id => params[:id]).first
			if tag.present?
				if tag.update(tag_params)
					render status: 200, json: {
						Description: "Successful operation",
						Tag: tag
					}.to_json
				else
					render status: 405, json: {
						Description: "Validation exception",
						messgae: tag.errors
					}.to_json
				end
			else
				render status: 404, json: {
						Description: "Tag not Found"
				}.to_json
			end
		else
			render status: 400, json: {
						Description: "Invalid ID/Data supplied"
			}.to_json
		end
	end

	private
	def tag_params
		params.require(:tag).permit(:name)
	end
end