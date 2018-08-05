Rails.application.routes.draw do
  resources :records do
    collection do
      get :export
      get :search
      put :load_csv
    end
  end

  namespace :divisions do
    get '/', action: :load_division_names
  end

  resources :drugstores
  resources :hospitals
  resources :hospital_transports
  resources :transports
  resources :people

  root 'records#search'
end
