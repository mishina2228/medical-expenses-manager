json.extract! patient, :id, :name, :relationship, :created_at, :updated_at
json.url patient_url(patient, format: :json)
