Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'contact_us/index'
  get 'users/new'
  get 'privacy_policy/index'
  get 'terms_of_service/index'
  get 'about/index'
  
  get 'home/index'

  # Session routes
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Users routes
  resources :users do
    resources :settings , only: [:index, :destroy]
    resources :password_changes, only: [:new, :create]
  end

  #Review routes
  resources :subjects do
    resources :comments
  end
  resources :comments do
    resources :comments
  end

  # Account Activation routes
  resources :account_activations, only: [:edit]

  # Password Reset Routes
  resources :password_resets, only: [:new,:create,:edit,:update]
  
  # Listing routes
  resources :listings

  # Search routes
  get :autocomplete_users, controller: :users
  get :autocomplete_listings, controller: :listings
  get '/search_users', to: 'users#search_users'
  get '/search_listings', to: 'listings#search_listings'
  root 'home#index'
end
