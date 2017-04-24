class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_question

	def create
		@comment = @question.comments.new(comment_params)
    	@comment.user = current_user

		if @comment.save
			redirect_to @question, notice: "Comment added"
	    else
	     	redirect_to @question, error: "Something went wrong"
	    end
	end

	private

	def set_question
    	@question = Question.find(params[:question_id])
  	end

	def comment_params
    	params.require(:comment).permit(:comment_markdown)
  	end
end
