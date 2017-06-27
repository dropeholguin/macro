class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:suspend, :approve]
  before_action :authenticate_admin_user!, only: [:suspend, :approve]
  before_action :card_time
	include ApplicationHelper
	include ActionView::Helpers::DateHelper

	def index
		user = current_user
		if params[:query].present? || params[:the_tag]
			questions_search = Question.search(params)
			@questions = []
			cards = Card.number_cards_submitted(user.id).pluck(:question_id)
			questions_search.each do |question|
				if cards.include?(question.id)
					@questions << question
				end
			end
		elsif params[:term]
			@questions = Question.ac_search(params[:term]).map(&:title)
    		render json: @questions
		else
			questions_search = Question.all.order("created_at desc")
			@questions = []
			cards = Card.number_cards_submitted(user.id).pluck(:question_id)
			questions_search.each do |question|
				if cards.include?(question.id)
					@questions << question
				end
			end
		end

		respond_with @questions
	end

	def cards_run_filter
		user = current_user
		cookies.delete(:cards)
		if params[:query].present? || params[:the_tag].present?
			questions = Question.search(params)
			questions_sort = []

			cards = Card.number_cards_submitted(user.id).pluck(:question_id)
			questions.each do |question|
				if !cards.include?(question.id)
					questions_sort << question
				end
			end
			@number_questions = questions_sort.count
			question_ids_array = questions_sort.pluck(:id).sort_by { rand }
	        question_array_string = question_ids_array.join("-")
	        cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }
		elsif params[:term]
			@questions = Question.ac_search(params[:term]).map(&:title)
    		render json: @questions
		end
	end

	def questions_list
		@user = current_user
		@questions = Question.questions_list(@user.id).order("created_at desc")
	end

	def tokens_wallet
		@user = current_user
		notifications = Notification.card_notifications(@user.id).order("created_at desc")
		number_notifications = Notification.number_notifications(@user.id)
		respond_to do |format|
		 	format.json  { render json: { tokens: @user.points, notifications: notifications, number_notifications: number_notifications.count } }
		end
	end

	def notification_state
		@user = current_user
		notifications = Notification.number_notifications(@user.id)
		if !notifications.empty?
			notifications.each do |notification|
				notification.update_attributes(state: true)
			end
		end
		head :ok
	end

  def card
    @user = current_user
    if @user.points > 0
      question_ids_array = cookies[:cards].split("-")
      first_question_id = question_ids_array.shift
      question_array_string = question_ids_array.join("-")
      cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }
      cookies[:time] = { value: Time.now, expires: 1.hours.from_now }

      @question = Question.find first_question_id.to_i
      if @question.present?
        @answers = @question.answers
        @comments = @question.comments.order("created_at desc")
        if @user.streak == 0
          @user.update_attributes(points: @user.points - 2)
          @notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: "You've earned -2 tokens", category: "tokens_negative", source: "#{question_path(@question)}")
          @notification.save
        end
      else
        respond_to do |format|
          format.html { redirect_to cards_run_filter_path, alert: 'There are no more questions available for your combination of tags' }
        end
      end	
    else 
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Points balance is zero.  Come back tomorrow!' }
      end
    end
  end

	def next_card
		question_ids_array = cookies[:cards].split("-")
        question_id = question_ids_array.shift
        question_array_string = question_ids_array.join("-")
        cookies[:cards] = { value: question_array_string, expires: 23.hours.from_now }
        cookies[:time] = { value: Time.now, expires: 1.hours.from_now }

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
		comments = card.comments.order("created_at desc")
		state = card.evaluators_for(:votes).include?(@user)
		votes = card.reputation_for(:votes).to_i
		time_long = true

		time = (Time.now.to_i - DateTime.parse(cookies[:time]).to_i)
		@card_time = Time.at(time).to_datetime
		cookies.delete(:time)

		if card.choice == "user input"
			is_passed = card.answers.first.answer_markdown.eql? params[:user_input]
		else
			answers_correct = card.answers.select { |answer| answer.is_correct == true }
			is_passed = answers_correct.map(&:id) == answers.map(&:to_i)
		end
		if is_passed == true && @card_time <= @time
			@user.update_attributes(streak: @user.streak + 1)
			if @user.streak < 9 && @user.streak >= 5
				@user.update_attributes(points: @user.points + 1)
				@notification = Notification.new(owner: card.user, user: current_user, question: card, message: "You've earned +1 tokens", category: "tokens_positive", source: "#{question_path(card)}")
				@notification.save
			elsif @user.streak >= 9
				@user.update_attributes(points: @user.points + 2)
				@notification = Notification.new(owner: card.user, user: current_user, question: card, message: "You've earned +2 tokens", category: "tokens_positive", source: "#{question_path(card)}")
				@notification.save
			end
		elsif @card_time >= @time
			time_long = false
			is_passed = false
			@user.update_attributes(streak: 0)
		else
			@user.update_attributes(streak: 0)
		end
		@card = Card.new(user_id: @user.id, question_id: card.id, is_passed: is_passed, time_at: @card_time)
		@card.save

		@creator = card.user
		@created_at = card.created_at.strftime("%b %d, %Y")
		@peoples_number = []
		@peoples_number_answered_correct = []

		#Number of people who have taken the question
		Card.question_cards(card.id).each do |card|
			if !@peoples_number.include?(card.user.id)
				@peoples_number << card.user.id
			end
		end
		#Number of people who have answered correct the question
		Card.questions_right(card.id).each do |card|
			if !@peoples_number_answered_correct.include?(card.user.id)
				@peoples_number_answered_correct << card.user.id
			end
		end

		@people_number = @peoples_number.count
		@peoples_number_answered_correct = @peoples_number_answered_correct.count

		@percentage_people =  ((@peoples_number_answered_correct.to_f / @people_number) * 100).round(2)

		respond_to do |format|
		 	format.json  { render json: { creator: @creator, created_at: @created_at, percentage_people: @percentage_people, people_number: @people_number, comments: comments, streak: @user.streak, state: state, is_passed: is_passed, votes: votes, time: @card.time_at.strftime("%M:%S"), time_long: time_long } }
		end
	end

	def show
		@peoples_number = []
		@peoples_number_answered_correct = []
		@creator = @question.user
		@created_at = @question.created_at.strftime("%b %d, %Y")

		#Number of people who have taken the question
		Card.question_cards(@question.id).each do |card|
			if !@peoples_number.include?(card.user.id)
				@peoples_number << card.user.id
			end
		end
		#Number of people who have answered correct the question
		Card.questions_right(@question.id).each do |card|
			if !@peoples_number_answered_correct.include?(card.user.id)
				@peoples_number_answered_correct << card.user.id
			end
		end

		@people_number = @peoples_number.count
		@peoples_number_answered_correct = @peoples_number_answered_correct.count

		@percentage_people =  ((@peoples_number_answered_correct.to_f / @people_number) * 100).round(2)

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
					format.html { redirect_to new_question_url, alert: 'At least one answer must be correct' }
				elsif state == true
					format.html { redirect_to new_question_url, alert: 'Incorrect Topic' }
				else
					if @question.save
						format.html { redirect_to questions_list_url, notice: 'Question was successfully created.' }
						format.json { render :show, status: :created, location: @question }
					else
						format.html { render :new }
						format.json { render json: @question.errors, status: :unprocessable_entity }
					end
				end	
			else
				if state == true
					format.html { redirect_to new_question_url, alert: 'Incorrect Topic' }
				else
					if @question.save
						format.html { redirect_to questions_list_url, notice: 'Question was successfully created.' }
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
		    format.html { redirect_to questions_list_url, notice: 'Question was successfully updated.' }
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
		  format.html { redirect_to questions_list_url, notice: 'Question was successfully removed.' }
		  format.json { head :no_content }
		end
	end

	def vote
		value = params[:type] == "up" ? 1 : -1
		@question = Question.find(params[:id])
		author = @question.user

		if value == 1
			message = "+#{value} #{current_user.name} has voted his card"
		else
			message = "#{value} #{current_user.name} has voted his card"
		end

		if author != current_user
			@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: message, category: "vote", source: "#{question_path(@question)}")
			@notification.save
			@question.add_or_update_evaluation(:votes, value, current_user)

			if @question.reputation_for(:votes).to_i == 4
				author.update_attributes(points: author.points + 32)
			end
		end
	end

	def suspend
        @question = Question.find(params[:id])
        @question.update_attributes(suspended: true)
        respond_to do |format|
        	@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: "Your card #{@question.title} has been suspended", category: "suspend", source: "#{question_path(@question)}")
			@notification.save
            ModelMailer.suspend_question(@question).deliver
            format.html { redirect_to admin_questions_path, notice: 'question was suspended.' }
            format.json { head :no_content }
        end
    end

    def approve
        @question = Question.find(params[:id])
        @question.update_attributes(suspended: false)
        respond_to do |format|
        	@notification = Notification.new(owner: @question.user, user: current_user, question: @question, message: "Your card #{@question.title} has been reactivated", category: "reactivate", source: "#{question_path(@question)}")
			@notification.save
            ModelMailer.approve_question(@question).deliver
            format.html { redirect_to admin_questions_path, notice: 'question was Approved.' }
            format.json { head :no_content }
        end
    end

	private
		def card_time
			@time = 2.minutes
		end

		def set_question
		  @question = Question.find(params[:id])
		end

		def question_params
		  params.require(:question).permit(:title, :description_markdown, :explanation_markdown, :choice, { tag_list: [] }, answers_attributes: [:id, :answer_markdown, :is_correct, :_destroy])
		end
end
