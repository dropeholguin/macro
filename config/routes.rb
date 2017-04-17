Rails.application.routes.draw do

	mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
	root to: "home#index"

	resources :questions

	post "run_question", to: 'questions#run_question'
	get "user_profile", to: 'profile#user_profile'
end
