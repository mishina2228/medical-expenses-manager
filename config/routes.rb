Rails.application.routes.draw do
  namespace :records do
    get '/export', action: :export
    get '/search', action: :search
    put '/load_csv', action: :load_csv
  end

  namespace :divisions do
    get '/', action: :load_division_names
  end

  resources :drugstores
  resources :hospitals
  resources :hospital_transports
  resources :transports
  resources :people
  resources :records

  root 'records#search'
end
