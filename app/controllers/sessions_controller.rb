class SessionsController < ApplicationController
	before_filter :authenticate_user!

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
			if @session.save
				if !params[:question][:ids].empty?
					params[:question][:ids].each do |question_id|
						question = Question.find question_id
						take = Take.new(question_id: question.id, session_id: @session.id)
						take.save
					end
				end	
				format.html { redirect_to sessions_path, notice: 'session was successfully created.' }
				format.json { render :show, status: :created, location: @session }
			else
				format.html { render :new }
				format.json { render json: @session.errors, status: :unprocessable_entity }
			end
		end
 	end

 	def run_sessions
		@user = current_user
		@session = Session.find params[:session_id]
		@questions = []
		@session.takes.each do |take|
			@questions << take.question
		end
	end

	def run_card
		@user = current_user
		answers = params[:checkbox]
		card = Question.find params[:card_id]
		
		answers_correct = card.answers.select { |answer| answer.is_correct == true }
		is_passed = answers_correct.map(&:id) == answers.map(&:to_i)

		@card = Card.new(user_id: @user.id, question_id: card.id, is_passed: is_passed)
		@card.save
	end

 	private
 		def session_params
		  params.require(:session).permit(:title)
		end
end
