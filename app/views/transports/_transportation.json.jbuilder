# frozen_string_literal: true

json.extract! transport, :id, :name, :created_at, :updated_at
json.url transport_url(transport, format: :json)
