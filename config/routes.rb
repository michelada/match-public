Rails.application.routes.draw do
  resources :api_activities
  resources :api_teams
  resources :activities
  resources :teams
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
  namespace :judge do
    resources :main, only: [:index]
  end
end
