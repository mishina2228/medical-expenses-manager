# frozen_string_literal: true

json.extract! hospital, :id, :name, :expense, :transports, :created_at, :updated_at
json.url hospital_url(hospital, format: :json)
