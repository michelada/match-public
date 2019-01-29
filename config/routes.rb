Rails.application.routes.draw do
  namespace :api do
    resources :activities, only: [:index]
    resources :teams, only: [:index]
  end
  resources :activities
  resources :teams
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
  namespace :judge do
    resources :main, only: [:index]
    resources :activities, only: %w[index show] do
      resources :activity_status, only: %w[create update]
    end
  end

  namespace :admin do
    resources :user_manager, only: %w[index update]
  end

  resources :activities, only: [:show] do
    resources :feedbacks, only: %w[index create delete update]
  end
end
