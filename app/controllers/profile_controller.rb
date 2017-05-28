class ProfileController < ApplicationController
	before_filter :authenticate_user!
	def user_profile
		@user = current_user
		@number_session_passeds = StatsSession.number_session_passed(@user.id).count
		@number_cards_submitted = Card.number_cards_submitted(@user.id).count
	end
end
