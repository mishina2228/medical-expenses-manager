# frozen_string_literal: true

json.extract! record, :id, :cost, :created_at, :updated_at
json.url record_url(record, format: :json)
