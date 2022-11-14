# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :attendances
  resources :meetings
  #get '/meetings' , to: 'meetings#index'
  #get '/meetings/show/:id' , to: 'meetings#show'
  #post '/meetings/create' , to: 'meetings#create'
  #put '/meetings/update/:id' , to: 'meetings#update'
  #delete '/meetings/delete/:id' , to: 'meetings#destroy'
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
