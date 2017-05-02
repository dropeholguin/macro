Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
		resources :comments, only: [:create, :destroy] do
			member do
				post :vote
			end
		end
	end

	resources :flags, only: [:create]
	resources :sessions, only: [:new, :create, :index]
	
	post "run_question", to: 'questions#run_question'
	post "next_card", to: 'questions#next_card'
	post "run_card", to: 'sessions#run_card'
	get "run_cards", to: 'questions#card'
	get "run_sessions", to: 'sessions#run_sessions'
	get "user_profile", to: 'profile#user_profile'
	get "import_and_export", to: 'questions#import_and_export'
	get "questions_list", to: 'questions#questions_list'
end
