Rails.application.routes.draw do

  root "users#index"

  resources :users
  resources :campaigns

  post 'address_lookup', to: 'addresses#new'
  post 'authenticate', to: 'authentication#authenticate'

end
