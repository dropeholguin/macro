Rails.application.routes.draw do

  get 'welcome/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations" }
  root to: "home#index"

  resources :questions
end
