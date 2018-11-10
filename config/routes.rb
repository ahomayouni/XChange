Rails.application.routes.draw do
  get 'groups/index'
  get 'groups/show'
  get 'groups/new'
  post 'groups/join'
  post 'groups/leave'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get 'contact_us/index'
  get 'users/new'
  get 'privacy_policy/index'
  get 'terms_of_service/index'
  get 'about/index'
  get '/borrow_requests/:listing_id', to: 'borrow_requests#send_request', as: 'borrow_requests'
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
  resources :people do
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
  
  # Groups routes
  resources :groups
  get :join, controller: :groups
  get :leave, controller: :groups
  post '/groups/join', to: 'group#join'
  post '/groups/leave', to: 'group#leave'

  # Search routes
  get :autocomplete_users, controller: :users
  get :autocomplete_listings, controller: :listings
  get :autocomplete_groups, controller: :groups
  get '/search_users', to: 'users#search_users'
  get '/search_listings', to: 'listings#search_listings'
  get '/search_groups', to: 'groups#search_groups'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  root 'home#index'
end
