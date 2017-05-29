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
					@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: "#{current_user.name} has flagged his card", category: "flag")
					@notification.save
					@question.update_attributes(count_flags: @question.count_flags + 1)
		            if @question.count_flags >= 2
		              @question.update_attributes(suspended: true)
		              ModelMailer.suspend_question(@question).deliver
		            end
					format.html { redirect_to @question, notice: 'flag was successfully created.' }
					format.json { render :show, status: :created, location: @flag}
				else
					format.html { redirect_to root_path, alert: 'Complete the Reason' }
					format.json { render json: @flag.errors, status: :unprocessable_entity }  
				end
			else
				format.html { redirect_to root_path, alert: "You can't flag your own question" }
			end
	    end
	end
end
