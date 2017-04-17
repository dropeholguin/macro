class ProfileController < ApplicationController
	before_filter :authenticate_user!
	def user_profile
		@user = current_user
	end
end
