Rails.application.routes.draw do
  resources :drugstores
  resources :transportation
  resources :records
  resources :hospitals
  resources :patients

  root 'records#index'
end
