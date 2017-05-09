class QuestionsController < ApplicationController
	before_action :set_question, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!
	include ApplicationHelper

	def index
		if params[:query].present? || params[:the_tag]
			@questions = Question.search(params)
		elsif params[:term]
			@questions = Question.ac_search(params[:term]).map(&:title)
    		render json: @questions
		else
			@questions = Question.all.order("created_at desc")
		end
	end

	def questions_list
		@user = current_user
		@questions = Question.questions_list(@user.id)
	end

	def card
		@user = current_user
		if @user.points > 0
			questions = Question.all.sort_by{rand}
			question_ids_array = questions.pluck(:id)
	        first_question_id = question_ids_array.shift
	        question_array_string = question_ids_array.join("-")
	        cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }

	        @question = Question.find first_question_id.to_i
			if !@question.nil?
				@answers = @question.answers
				@comments = @question.comments.order("created_at desc")	
				@state = @question.evaluators_for(:votes).include?(current_user)
				if @user.streak < 0
					@user.update_attributes(streak: 0)
					respond_to do |format|
						format.html { redirect_to root_path, alert: '' }
					end				
				elsif @user.streak == 0
					@user.update_attributes(points: @user.points - 2)
				end
			else
				respond_to do |format|
					format.html { redirect_to root_path, alert: '' }
				end
			end	
		else 
			respond_to do |format|
				format.html { redirect_to root_path, alert: '' }
			end		
		end
	end

	def next_card
		question_ids_array = cookies[:cards].split("-")
        question_id = question_ids_array.shift
        question_array_string = question_ids_array.join("-")
        cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }

        @question = Question.find question_id.to_i
        @description = markdown(@question.description_markdown)
        @explanation = markdown(@question.explanation_markdown)

		respond_to do |format|
		 	format.json  { render json: { question: @question, answers: @question.answers, tag_list: @question.tag_list, description: @description, explanation: @explanation } }
		end
	end

	def run_question
		@user = current_user
		answers = params[:checkbox]
		card = Question.find params[:card_id]
		@comments = card.comments
		
		answers_correct = card.answers.select { |answer| answer.is_correct == true }
		is_passed = answers_correct.map(&:id) == answers.map(&:to_i)
		if is_passed == true
			@user.update_attributes(streak: @user.streak + 1)
			if @user.streak < 9 && @user.streak >= 5
				@user.update_attributes(points: @user.points + 1)
			elsif @user.streak >= 9
				@user.update_attributes(points: @user.points + 2)
			end
		else
			@user.update_attributes(streak: -1)
		end
		@card = Card.new(user_id: @user.id, question_id: card.id, is_passed: is_passed)
		@card.save

		@creator = card.user
		@created_at = card.created_at.strftime("%b %d, %Y")
		@people_number = 0

		Card.question_cards(card.id).each do |card|
			if card.user.present?
				@people_number = @people_number + 1
			end
		end

		people = 0
		cards_count = Card.question_cards(card.id).count

		Card.questions_right(card.id).each do |card|
			if card.user.present?
				people = people + 1
			end
		end
		@percentage_people =  ((people.to_f / cards_count) * 100).round(2)

		respond_to do |format|
		 	format.json  { render json: { creator: @creator, created_at: @created_at, people_number: @people_number, percentage_people: @percentage_people, comments: @comments } }
		end
	end

	def show
		@answers = @question.answers
		@comments = @question.comments
		@state = @question.evaluators_for(:votes).include?(current_user)
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

		if params[:choice] == "multiple"
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
		else
			@question.choice = "user input"
		end
		
	  	@question.tag_list.each do |tag|
	  		unless Question.tags.include?(tag)
			   state = true
			end
	  	end

		respond_to do |format|
			if @question.choice == "multiple" || @question.choice == "simple"
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
			else
				if state == true
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

	def suspend
        @question = Question.find(params[:id])
        @question.update_attributes(suspended: true)
        respond_to do |format|
            ModelMailer.suspend_question(@question).deliver
            format.html { redirect_to admin_questions_path, notice: 'question was suspended.' }
            format.json { head :no_content }
        end
    end

    def approve
        @question = Question.find(params[:id])
        @question.update_attributes(suspended: false)
        respond_to do |format|
            ModelMailer.approve_question(@question).deliver
            format.html { redirect_to admin_questions_path, notice: 'question was Approved.' }
            format.json { head :no_content }
        end
    end

	private

		def set_question
		  @question = Question.find(params[:id])
		end

		def question_params
		  params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
