# frozen_string_literal: true

json.extract! person, :id, :name, :relationship, :created_at, :updated_at
json.url person_url(person, format: :json)
