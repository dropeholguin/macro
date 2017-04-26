class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
 	load_and_authorize_resource only: [:import_and_export]

	def index
		if params[:query].present? || params[:the_tag]
			@questions = Question.search(params)
		elsif params[:term]
			@questions = Question.ac_search(params[:term]).map(&:title)
    		render json: @questions
		else
			@questions = Question.all
		end
		respond_to do |format|
		  format.html
		  format.csv { send_data @questions.to_csv }
		  format.xls 
		end
	end

	def questions_list
		@user = current_user
		@questions = Question.questions_list(@user.id)
	end

	def card
		@user = current_user
		if @user.points > 0
			@question = Question.offset(rand(Question.count)).first
			@answers = @question.answers
			if @user.streak == 4
				@user.update_attributes(points: @user.points + 2)
			elsif @user.streak < 9 && @user.streak >= 5
				@user.update_attributes(points: @user.points + 3)
			elsif @user.streak >= 9
				@user.update_attributes(points: @user.points + 4)
			elsif @user.streak == 0
				@user.update_attributes(points: @user.points - 2)
			elsif @user.streak < 0
				@user.update_attributes(streak: 0)
				respond_to do |format|
					format.html { redirect_to questions_url, notice: '' }				
				end
			end
		else 
			respond_to do |format|
				format.html { redirect_to questions_url, notice: '' }
			end		
		end
	end

	def next_card
		
	end

	def run_question
		@user = current_user
		answers = params[:checkbox]
		card = Question.find params[:card_id]
		
		answers_correct = card.answers.select { |answer| answer.is_correct == true }
		is_passed = answers_correct.map(&:id) == answers.map(&:to_i)
		if is_passed == true
			@user.update_attributes(streak: @user.streak + 1)
		else
			@user.update_attributes(streak: -1)
		end
		@card = Card.new(user_id: @user.id, question_id: card.id, is_passed: is_passed)
		@card.save
		head :ok
	end

	def show
		@answers = @question.answers
		@comments = @question.comments
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
		state = false
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

	  	@question.tag_list.each do |tag|
	  		unless Question.tags.include?(tag)
			   state = true
			end
	  	end

		respond_to do |format|
			if count == 0
				format.html { render :new, notice: 'At least one question must be correct' }
			elsif state == true
				format.html { render :new, notice: 'Incorrect Topic' }
			else
				if @question.save
					format.html { redirect_to questions_url, notice: 'Question was successfully created.' }
					format.json { render :show, status: :created, location: @question }
				else
					format.html { render :new }
					format.json { render json: @question.errors, status: :unprocessable_entity }
				end
			end	  
		end
	end

	def update
		respond_to do |format|
		  if @question.update(question_params)
		    format.html { redirect_to questions_url, notice: 'Question was successfully updated.' }
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

	def vote
	  value = params[:type] == "up" ? 1 : -1
	  @question = Question.find(params[:id])
	  @question.add_or_update_evaluation(:votes, value, current_user)
	end

	def import_and_export
		
	end

	def import
		Question.import(params[:file])
		redirect_to root_url, notice: 'Questions imported.'
	end

	private

		def set_question
		  @question = Question.find(params[:id])
		end

		def question_params
		  params.require(:question).permit(:title, :description_markdown, :explanation_markdown, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
