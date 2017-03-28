class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
 
	def index
		@question = Question.all.order("created_at DESC")
	end

	def show

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
		  params.require(:question).permit(:title, :description_markdown, :explanation_markdown, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
