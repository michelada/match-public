Rails.application.routes.draw do
  namespace :api do
    resources :activities, only: [:index]
    resources :teams, only: [:index]
  end

  resources :invitation, only: [:index]
  resources :activities, except: [:index]
  resources :teams, except: [:index, :update]
  resources :main, only: [:index]
  resources :team_invitations, only: [:new, :create]
  devise_for :users, controllers: { registrations: 'invitation' }
  as :user do
    get '/users' => 'devise_invitable/registrations#new'
    get '/teams' => 'teams#new'
    get '/team_invitation' => 'team_invitations#new'
    get '/activities' => 'activities#new'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'
  namespace :judge do
    resources :activities, only: [:index, :show, :update] do
      resources :activity_status, only: [:create, :destroy]
      resources :feedbacks, only: [:index, :create]
      resources :locations, only: [:update]
    end
    resources :main, only: [:index]
  end

  namespace :admin do
    resources :user_manager, only: [:index, :update]
  end

  resources :activities, only: [:show] do
    resources :feedbacks, only: [:index, :create]
  end
end
