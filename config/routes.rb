Rails.application.routes.draw do
  get 'privacy_policy/index'
  get 'terms_of_service/index'
  get 'about/index'

  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root 'home#index'
end
