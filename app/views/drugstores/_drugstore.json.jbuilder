# frozen_string_literal: true

json.extract! drugstore, :id, :name, :created_at, :updated_at
json.url drugstore_url(drugstore, format: :json)
