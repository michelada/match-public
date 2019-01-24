Rails.application.routes.draw do
  resources :activities
  resources :locations, only: [:new, :index, :create]
  resources :teams
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
  namespace :judge do
    resources :main, only: [:index]
    resources :activities, only: %w[index show] do
      resources :activity_statuses, only: %w[update]
    end
  end

  resources :activities, only: [:show] do
    resources :feedbacks, only: %w[index create delete update]
  end
end
