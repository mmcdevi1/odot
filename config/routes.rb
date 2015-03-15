Rails.application.routes.draw do

  namespace :api do 
    resources :todo_lists
  end

  get "/login" => "user_sessions#new", as: :login
  delete "/logout" => "user_sessions#destroy", as: :logout
  
  resources :user_sessions, only: [:new, :create]

  resources :users

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :todo_lists do 
    resources :todo_items do 
      member do 
        patch :complete
      end
    end
  end

  root 'todo_lists#index'

end
