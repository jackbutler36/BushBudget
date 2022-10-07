Rails.application.routes.draw do
  resources :attendances
  get 'dashboard/index'
  resources :meetings
  resources :users
  root 'dashboard#index'
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
