# config/routes.rb

Rails.application.routes.draw do
  get 'pages/contact'
  get 'pages/about'

   # Root route
   root "products#index"



  # Devise routes for Admin users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for Customers
  devise_for :customers

  # Resource routes
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:show]
  resources :payments
  resources :taxes
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]  # Add update and destroy actions
  resources :admins
  resources :addresses
  resources :order_items
  resources :orders
  resources :customers


  # Checkout routes
  resource :checkout, only: [] do
    collection do
      get 'address'
      post 'confirm'
      get 'invoice'
    end
  end

  # Static pages
  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
end
