Rails.application.routes.draw do
  root "users#new"
  resources :users, only: [:new, :create, :show ]
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :edit, :destroy]
  resources :tasks
end
