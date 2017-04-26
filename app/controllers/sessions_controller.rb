class SessionsController < ApplicationController
	before_filter :authenticate_user!

 	def new
 		@session = Session.new
 		@questions = Question.all.order('created_at desc')
 	end

 	def create
 		@user = current_user
		@session = Session.new(session_params)
		@session.user = @user

		respond_to do |format|
			if @session.save
				if !params[:question][:ids].empty?
					params[:question][:ids].each do |question_id|
						question = Question.find question_id
						question.update_attributes(session_id: @session.id)
					end
				end	
				format.html { redirect_to root_url, notice: 'session was successfully created.' }
				format.json { render :show, status: :created, location: @session }
			else
				format.html { render :new }
				format.json { render json: @session.errors, status: :unprocessable_entity }
			end
		end
 	end

 	private
 		def session_params
		  params.require(:session).permit(:title)
		end
end
