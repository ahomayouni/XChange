Rails.application.routes.draw do
  get 'terms_of_service/index'
  get 'about/index'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
