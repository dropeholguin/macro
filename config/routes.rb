Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
	mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
	devise_for :users, controllers: { unlocks: 'users/unlocks', confirmations: 'users/confirmations', omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
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

	resources :uploads, only: [:create]
  resource :auth, only: [] do
    collection do
      post 'linkedin'
      post 'facebook'
    end
  end
	
	get "cards_run_filter", to: 'questions#cards_run_filter'
	get "sessions_stats", to: 'sessions#sessions_stats'
	get "run_cards", to: 'questions#card'
	get "run_sessions", to: 'sessions#run_sessions'
	get "user_profile", to: 'profile#user_profile'
	get "questions_list", to: 'questions#questions_list'
	get 'terms', to: 'home#terms_and_conditions'
	get 'privacy', to: 'home#privacy_policy', as: :privacy
	patch 'privacy/:id/accept', to: 'home#accept_privacy', as: :accept_privacy
	patch "questions/suspend_question/:id", to: 'questions#suspend', as: :suspend
 	patch "questions/approve_question/:id", to: 'questions#approve', as: :approve
 	post "sessions_next_card", to: 'sessions#next_card'
 	post "tokens_wallet", to: 'questions#tokens_wallet'
 	post "run_question", to: 'questions#run_question'
	post "next_card", to: 'questions#next_card'
	post "run_card", to: 'sessions#run_card'
 	post "search_cards", to: 'sessions#search_cards'
 	post "users/lock/:id", to: 'locks#lock_access', as: :lock_access
 	post "notification_state", to: 'questions#notification_state'
end
