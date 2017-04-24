Rails.application.routes.draw do

	mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
	root to: "home#index"

	resources :questions do
		collection do
			post :import
		end
		member do
			post :vote
		end
		resources :comments, only: [:create, :destroy]
	end

	post "run_question", to: 'questions#run_question'
	post "next_card", to: 'questions#next_card'
	get "run_cards", to: 'questions#card'
	get "user_profile", to: 'profile#user_profile'
	get "import_and_export", to: 'questions#import_and_export'
	get "questions_list", to: 'questions#questions_list'
end
