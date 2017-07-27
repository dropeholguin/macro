FactoryGirl.define do
  factory :reason do
    text "MyText"
  end
	factory :user do
		name "name"
		email "dropeholguin1994@gmail.com"
		points 0
		confirmed_at Time.now
		password "password"
		password_confirmation "password"
	end
	factory :question do
		id 1
		title "A Catskill Eagle"
		description_markdown "description_markdown"
		explanation_markdown "explanation_markdown"
		choice "simple"
	end
end
