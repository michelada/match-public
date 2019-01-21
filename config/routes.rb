Rails.application.routes.draw do
  resources :activities
  resources :teams
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'index#index'
end
