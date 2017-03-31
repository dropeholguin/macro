class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
 
	def index
		@questions = Question.search(params)
	end

	def show
		@answers = @question.answers
	end

	def new
		@question = Question.new
		3.times do
		  @question.answers.build
		end
	end

	def edit

	end

	def create
		@user = current_user
		@question = Question.new(question_params)
		@question.user = @user
		count = 0

		@question.answers.each do |answer|
			if answer.is_correct == true
				count = count + 1 
			end
		end

		if count > 1
			@question.choice = "multiple"
	  	else
	  		@question.choice = "simple"
	  	end
		respond_to do |format|
		  if @question.save
		  	format.html { redirect_to questions_url, notice: 'Question was successfully created.' }
		    format.json { render :show, status: :created, location: @question }
		  else
		    format.html { render :new }
		    format.json { render json: @question.errors, status: :unprocessable_entity }
		  end
		end
	end

	def update
		respond_to do |format|
		  if @question.update(question_params)
		    format.html { redirect_to @question, notice: 'Question was successfully updated.' }
		    format.json { render :show, status: :ok, location: @question }
		  else
		    format.html { render :edit }
		    format.json { render json: @question.errors, status: :unprocessable_entity }
		  end
		end
	end

	def destroy
		@question.destroy
		respond_to do |format|
		  format.html { redirect_to questions_url, notice: 'Question was successfully removed.' }
		  format.json { head :no_content }
		end
	end

	private

		def set_question
		  @question = Question.find(params[:id])
		end

		def question_params
		  params.require(:question).permit(:title, :description_markdown, :explanation_markdown, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
