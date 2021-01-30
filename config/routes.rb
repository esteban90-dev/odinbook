Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static_pages#welcome"
  
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }
  resources :users, only: :index
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: :index
end
