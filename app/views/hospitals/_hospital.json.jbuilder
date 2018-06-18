json.extract! hospital, :id, :name, :expense, :transportation, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
