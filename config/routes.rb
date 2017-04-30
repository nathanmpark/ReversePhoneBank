Rails.application.routes.draw do

  root "users#index"

  resources :users
  resources :campaigns

  post 'address_lookup', to: 'addresses#new'
  post 'authenticate', to: 'authentication#authenticate'

  post 'find_reps', to: 'reps#find_reps'

  put 'campaigns/:id/:rep_uuid', to: 'campaigns#add_reps'

end
