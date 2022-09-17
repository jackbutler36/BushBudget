Rails.application.routes.draw do
  resources :users
  root 'users#index'

  resources :books do
    member do
      get :delete
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
