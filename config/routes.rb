Rails.application.routes.draw do
  devise_for :users 
  resources :attendances
  resources :meetings
  resources :users 
  resources :dashboard
  resources :admin_docs
  root 'dashboard#index'
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
