Rails.application.routes.draw do
  namespace :api do
    resources :activities, only: [:index]
    resources :teams, only: [:index]
  end
  resources :activities, except: [:index]
  resources :teams
  resources :main, only: [:index]
  resources :team_invitations, only: [:new, :create]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'
  namespace :judge do
    resources :activities, only: %w[index show update] do
      resources :activity_status, only: %w[create update]
      resources :feedbacks, only: %w[index create]
      resources :locations, only: %w[update]
    end
    resources :main, only: [:index]
  end

  namespace :admin do
    resources :user_manager, only: %w[index update]
  end

  resources :activities, only: [:show] do
    resources :feedbacks, only: %w[index create]
  end
end
