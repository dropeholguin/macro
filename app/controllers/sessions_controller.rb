class SessionsController < ApplicationController
	before_filter :authenticate_user!
	include ApplicationHelper

	def index
		@sessions = Session.all.order('created_at desc')
	end

 	def new
 		@session = Session.new
 		if params[:query].present? || params[:the_tag]
			@questions = Question.search(params)
		elsif params[:term]
			@questions = Question.ac_search(params[:term]).map(&:title)
    		render json: @questions
		else
			@questions = Question.all.order('created_at desc')
		end
 	end

 	def create
 		@user = current_user
		@session = Session.new(session_params)
		@session.user = @user

		respond_to do |format|
			if !params[:question].nil? && params[:question][:ids].size == 16
				if @session.save
					params[:question][:ids].each do |question_id|
						question = Question.find question_id
						take = Take.new(question_id: question.id, session_id: @session.id)
						take.save
					end
					format.html { redirect_to sessions_path, notice: 'session was successfully created.' }
					format.json { render :show, status: :created, location: @session }
				else
					format.html { redirect_to new_session_path }
					format.json { render json: @session.errors, status: :unprocessable_entity }
				end
			else
				format.html { redirect_to new_session_path }
				format.json { render json: @session.errors, status: :unprocessable_entity }
			end
		end
 	end

 	def run_sessions
		@session = Session.find params[:session_id]
		questions = []
		@session.takes.each do |take|
			questions << take.question
		end
		question_ids_array = questions.pluck(:id)
        first_question_id = question_ids_array.shift
        question_array_string = question_ids_array.join("-")
        cookies[:questions] = { value: question_array_string, expires: 23.hours.from_now }

		@question = Question.find first_question_id.to_i
	end

	def next_card
		question_ids_array = cookies[:questions].split("-")
        question_id = question_ids_array.shift
        question_array_string = question_ids_array.join("-")
        cookies[:questions] = { value: question_array_string, expires: 23.hours.from_now }

        @question = Question.find question_id.to_i
        @description = markdown(@question.description_markdown)

		respond_to do |format|
		 	format.json  { render json: { question: @question, answers: @question.answers, tag_list: @question.tag_list, description: @description, remaining_card: (question_ids_array.size + 1) } }
		end
	end

	def run_card
		@user = current_user
		answers = params[:checkbox]
		card = Question.find params[:card_id]
		session = Session.find params[:session]

		answers_correct = card.answers.select { |answer| answer.is_correct == true }
		@is_passed = answers_correct.map(&:id) == answers.map(&:to_i)

		@session_card = SessionCard.new(user_id: @user.id, question_id: card.id, is_passed: @is_passed, session_id: session.id )
		@session_card.save

		respond_to do |format|
		 	format.json  { render json: { is_passed: @is_passed, tokens: @user.points } }
		end
	end

	def sessions_stats
		
	end

 	private
 		def session_params
		  params.require(:session).permit(:title)
		end
end
