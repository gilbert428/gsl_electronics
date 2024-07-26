Rails.application.routes.draw do
  root "products#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :customers

  resources :products, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:show]
  resources :payments, only: [:new, :create]
  resources :stripe_checkout, only: [:create, :index]

  get 'checkout', to: 'stripe_checkout#checkout', as: 'checkout'

  post 'stripe/webhook', to: 'stripe_webhooks#event'
  resources :taxes
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :admins
  resources :addresses
  resources :order_items
  resources :stripe_checkout, only: [:create]
  resources :orders, only: [:index, :show, :new, :create] do
    collection do
      get 'success'
      get 'cancel'
    end
  end
  resources :customers



  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  get "up" => "rails/health#show", as: :rails_health_check
end
