Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  authenticated :user do
    root to: 'posts#index', as: :authenticated_root
  end
  
  root to: redirect('/users/sign_in')
  
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: 'registrations' }

  resources :users, only: :index, shallow: true do 
    resources :friendships, only: [:index, :destroy]
    resources :notifications, only: :index
    resources :posts, only: [:show, :create, :edit, :update, :destroy] do 
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :edit, :update, :destroy]
    end
    resource :profile, only: [:show, :new, :create, :edit, :update]
  end

  resources :friend_requests, only: [:index, :create] do 
    member do
      delete :accept
      delete :ignore
    end
  end

  resources :posts, only: [:index]

end
