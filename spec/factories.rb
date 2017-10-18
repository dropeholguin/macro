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
		title "A Catskill Eagle"
		description_markdown "description_markdown"
		explanation_markdown "explanation_markdown"
		choice "simple"
		tag_list "SAS Programming, DI Studio"
		state "activated"
	end
	factory :answer do
		answer_markdown "answer_markdown"
		is_correct "false"
	end
	factory :topic do
		id 4
		name 'DI Studio'
		desc "Studio"
	end
end
