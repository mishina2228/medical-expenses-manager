Rails.application.routes.draw do
  resources :drugstores
  resources :hospitals
  resources :hospital_transports
  resources :transports
  resources :people
  resources :records

  get '/divisions/', to: 'divisions#load_division_names'

  root 'records#index'
end
