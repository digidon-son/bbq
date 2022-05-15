Rails.application.routes.draw do
  resources :photos
  devise_for :users

  root 'events#index'

  resources :events do
    resources :subscriptions, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: %i[show edit update]
end
