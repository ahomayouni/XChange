Rails.application.routes.draw do
  resources :live_searches
  get 'groups/index'
  get 'groups/show'
  post 'groups/show'
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

  #get '/borrow_reauests'
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
  resources :users do
    resources :comments
  end

  resources :listings do
    resources :comments
  end
  resources :comments do
    resources :comments
  end

  #Private messaging routes
  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages

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
  get :autocomplete_add_to_groups, controller: :groups
  get '/search_users', to: 'users#search_users'
  get '/search_listings', to: 'listings#search_listings'
  get '/search_groups', to: 'groups#search_groups'
  get '/search_add_to_groups', to: 'groups#search_add_to_groups'
  get '/add_to_group/:user_id', to: 'groups#add_to_group', as: 'add_to_group'

  # Location routes
  resources :locations


  # resources :borrow_requests
  # get :requested_listings, controller: :borrow_requests
  # get :need_approval, controller: :borrow_requests

  get '/borrow_requests/:listing_id', to: 'borrow_requests#send_request', as: 'create_borrow_request'
  patch 'borrow_request/:id', to: 'borrow_requests#approve', as: 'borrow_approve'
  get '/borrow_request/:id', to: 'borrow_requests#decline', as: 'borrow_decline'
  delete '/borrow_request/:id', to: 'borrow_requests#delete_request', as: 'borrow_delete'

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  root 'home#index'
end
