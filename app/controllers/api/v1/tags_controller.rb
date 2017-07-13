class Api::V1::TagsController < ApplicationController
	before_action :authenticate_user!

	def index
		tags = Topic.all
		if tags.present?
			render json: tags.map{ |tag| {tagID: tag.id, tagName: tag.name, tagDesc: tag.desc }}
		else
			render status: 404, json: {
					message: "No tags found"
			}.to_json
		end
	end
	
	def update
		if  ((Integer(params[:id]) rescue false)&&params[:tag].present?)
			tag = Tag.where(:id => params[:id]).first
			if tag.present?
				if tag.update(tag_params)
					render status: 200, json: {
						message: "Successful operation",
						Tag: tag
					}.to_json
				else
					render status: 405, json: {
						message: "Validation exception",
						messgae: tag.errors
					}.to_json
				end
			else
				render status: 404, json: {
						message: "Tag not Found"
				}.to_json
			end
		else
			render status: 400, json: {
						message: "Invalid ID/Data supplied"
			}.to_json
		end
	end

	private
	def tag_params
		params.require(:topic).permit(:name, :desc)
	end
end
