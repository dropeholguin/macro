class FlagsController < ApplicationController
	before_action :authenticate_user!

	def create
	    @question = Question.find(params[:question_id])
	    @flag = Flag.new(reason: params[:reason])
	    @flag.user = current_user
	    @flag.question_id = @question.id

	    respond_to do |format|
			if @question.user != current_user
				if @flag.save
					format.html { redirect_to root_path, notice: 'flag was successfully created.' }
					format.json { render :show, status: :created, location: @flag}
				else
					format.html { redirect_to root_path, alert: 'Complete the Reason' }
					format.json { render json: @flag.errors, status: :unprocessable_entity }  
				end
			else
				format.html { redirect_to root_path, alert: "You can't flag your own photo" }
			end
	    end
	end
end
