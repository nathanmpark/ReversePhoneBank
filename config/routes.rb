Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users
  post 'address_lookup', to: 'addresses#new'
  post 'authenticate', to: 'authentication#authenticate'

end
