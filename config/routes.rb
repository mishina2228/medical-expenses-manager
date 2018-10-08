Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join('|')}/ do
    root 'records#search'

    resources :records do
      collection do
        get :export
        get :search
        put :load_csv
        put :create_loaded
      end
    end

    namespace :divisions do
      get '/', action: :load_division_names
    end

    namespace :record_statistics do
      get '/', action: :index
    end

    resources :drugstores
    resources :hospitals
    resources :hospital_transports
    resources :transports
    resources :people
  end
end
