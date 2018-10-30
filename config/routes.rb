Rails.application.routes.draw do
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
  get '/logout', to: 'sessions#destroy'

  # Users routes 
  resources :users
  
  root 'home#index'
end
