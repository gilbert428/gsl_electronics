# config/routes.rb
Rails.application.routes.draw do
  get 'pages/contact'
  get 'pages/about'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :customers, controllers: {
    registrations: 'customers/registrations'
  }, path_names: {
    sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'sign_up'
  }

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:show]

  resources :payments
  resources :taxes
  resources :cart_items
  resources :carts
  resources :admins
  resources :addresses
  resources :order_items
  resources :orders
  resources :customers

  root "products#index"

  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'

  get "up" => "rails/health#show", as: :rails_health_check
end
