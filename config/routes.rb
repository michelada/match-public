Rails.application.routes.draw do
  namespace :api do
    resources :activities, only: [:index]
    resources :teams, only: [:index]
  end

  devise_for :users
  resources :location, only: [:new]
  resources :activities, only: [] do
    resources :uploads, only: [:destroy]
  end

  resources :match, only: [:show] do
    resources :teams, except: [:index, :update]
    resources :main, only: [:index]
    resources :team_invitations, only: [:new, :create]
    resource :user, only: [:update]
    resources :projects, except: [:index, :destroy]

    resources :activities, except: [:index] do
      resources :feedbacks, only: [:index, :create, :update]
    end

    resources :polls, only: [:show] do
      resources :activities, only: [:index] do
        resources :votes, only: [:create, :destroy]
      end
    end

    namespace :judge do
      resources :activities, only: [:show, :update] do
        resources :activity_status, only: [:create, :destroy]
        resources :feedbacks, only: [:index, :create, :update]
        resources :locations, only: [:update]
      end
      resources :polls, only: [:show] do
        resources :activities, only: [:index] do
          resources :votes, only: [:create, :destroy]
        end
      end
      resources :main, only: [:index]
    end

    as :user do
      get '/users' => 'devise_invitable/registrations#new'
      get '/teams' => 'teams#new'
      get '/team_invitation' => 'team_invitations#new'
      get '/activities' => 'activities#new'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing_page#index'

  namespace :admin do
    resources :user_manager, only: [:index, :update, :destroy]
    resources :matches
  end
end
