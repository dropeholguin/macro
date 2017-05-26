class SessionsController < ApplicationController
	before_filter :authenticate_user!
	include ApplicationHelper

	def index
		user = current_user
		@sessions = []
		Session.all.order('created_at desc').each do |session|
			stats_session = StatsSession.stats_session(session.id, user.id)
			if !stats_session.present?
				@sessions << session
			end
		end
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
			if !params[:question].nil? && params[:question][:ids].size == 3
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
		session_ids_array = SessionCard.session_cards_correct(@session.id, current_user.id).pluck(:id)
		SessionCard.where(id: session_ids_array).destroy_all

		question_ids_array = questions.pluck(:id)
        first_question_id = question_ids_array.shift
        question_array_string = question_ids_array.join("-")
        cookies[:questions] = { value: question_array_string, expires: 23.hours.from_now }
        cookies[:session_id] = { value: @session.id, expires: 1.hours.from_now }
        cookies[:session_time] = { value: Time.now, expires: 4.hours.from_now }

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
		if !cookies[:session_id].nil?
			@user = current_user
			session = Session.find cookies[:session_id]
			@cont = SessionCard.session_cards_correct(session.id, @user.id).count
			@percentage_session = ((@cont.to_f / 16) * 100).round(2)
			@passed_session = false
			@result = "Fail"

			if @percentage_session == 100
				@user.update_attributes(points: @user.points + 16)
				@result = "High Score!!"
				@passed_session = true
			elsif @percentage_session >= 75
				@passed_session = true
				@result = "Pass"
			end

			time = (Time.now.to_i - DateTime.parse(cookies[:session_time]).to_i)
			session_time = Time.at(time).to_datetime

			@stats_session = StatsSession.new(user_id: @user.id, is_passed: @passed_session, session_id: session.id, percentage: @percentage_session, time_at: session_time, number_cards_correct: @cont)
			@stats_session.save
			@peoples_number = []
			@peoples_number_passed_session = []
			@time_at = @stats_session.time_at.strftime("%M:%S")

			#Number of people who have taken the session
			StatsSession.peoples_session(session.id).each do |stats_session|
				if !@peoples_number.include?(stats_session.user.id)
					@peoples_number << stats_session.user.id
				end
			end
			#Number of people who have passed the session
			StatsSession.stats_sessions(session.id).each do |stats_session|
				if !@peoples_number_passed_session.include?(stats_session.user.id)
					@peoples_number_passed_session << stats_session.user.id
				end
			end

			people_number = @peoples_number.count
			peoples_number_passed_session = @peoples_number_passed_session.count

			@percentage_people =  ((peoples_number_passed_session.to_f / people_number) * 100).round(2)

			#method for get Highest score
			@score_stats_session = []
			people_score = []
			StatsSession.peoples_session(session.id).order("number_cards_correct desc, time_at asc").each do |stat_session|
				if !people_score.include?(stat_session.user.id)
					people_score << stat_session.user.id
					@score_stats_session << stat_session
				end
			end

			@highest_score = @score_stats_session.first

			cookies.delete(:session_id)
		else
			respond_to do |format|
				format.html { redirect_to sessions_path }
			end
		end
	end

 	private
 		def session_params
		  params.require(:session).permit(:title)
		end
end
