namespace :renew_balance do
	desc 'Renew balance when it is below 8'
	task balance: :environment do
		users = User.users_with_less_of_eight_cards

		users.each do |user|
			user.update_attributes(points: 0)
			user.change_points(8)
		end
	end
end