Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "static_pages#welcome"
  
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  resources :users, only: :index do 
    resources :notifications, only: :index
    resource :profile, only: [:show, :edit]
  end

  resources :friend_requests, only: [:index, :create] do 
    member do
      delete :accept
      delete :ignore
    end
  end

  resources :friendships, only: [:index, :destroy]
end
