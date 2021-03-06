class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_question

	def create
		@comment = @question.comments.new(comment_params)
    	@comment.user = current_user

		if @comment.save
			@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: "#{current_user.name} commented on his card", category: "comment", source: "#{question_path(@question)}")
			@notification.save
	    end
	    head :ok
	end

	def vote
	  value = params[:type] == "up" ? 1 : -1
	  @comment = Comment.find(params[:id])
	  @comment.add_or_update_evaluation(:votes, value, current_user)
	  redirect_to :back
	end

	private

	def set_question
    	@question = Question.find(params[:question_id])
  	end

	def comment_params
    	params.require(:comment).permit(:comment_markdown)
  	end
end
