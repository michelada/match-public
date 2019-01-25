Rails.application.routes.draw do
  namespace :api do 
    resources :activities, only: [:index]
    resources :teams, only: [:index]
  end
  resources :activities
  resources :locations, only: [:new, :index, :create]
  resources :teams
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
  namespace :judge do
    resources :main, only: [:index]
  end
end
