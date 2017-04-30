Rails.application.routes.draw do

  root "users#index"

  resources :users
  post 'authenticate', to: 'authentication#authenticate'

  resources :campaigns
  put 'campaigns/:id/:rep_uuid', to: 'campaigns#add_reps'
  get 'campaigns/:campaign_id/user_reps', to: 'campaigns#user_reps'

  post 'address_lookup', to: 'addresses#new'

  post 'find_reps', to: 'reps#find_reps'

end
