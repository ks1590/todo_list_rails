Rails.application.routes.draw do
  root "users#new"
  resources :users
  resources :sessions, only: [:new, :create, :edit, :destroy]
  resources :tasks
end
