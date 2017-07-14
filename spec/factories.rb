FactoryGirl.define do
	factory :user do
		name "name"
		sequence(:email) { |n| "user#{n}@macropeople.com"}
		points 0
		confirmed_at Time.now
		password "password"
		password_confirmation "password"
	end
end