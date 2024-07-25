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
  resources :stripe_checkout, only: :create
  get 'success', to: 'orders#success'
  get 'cancel', to: 'orders#cancel'
  resources :taxes
  resources :carts, only: [:show]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :admins
  resources :addresses
  resources :order_items
  resources :orders
  resources :customers

  resource :checkout, only: [] do
    collection do
      get '/', to: 'checkouts#show', as: 'checkout'
      get 'address'
      post 'confirm'
      get 'invoice'
    end
  end

  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
  get "up" => "rails/health#show", as: :rails_health_check
end
