# frozen_string_literal: true

class Person < ApplicationRecord
  acts_as_paranoid

  has_many :records, dependent: :destroy

  validates :name, presence: true, uniqueness: {scope: [:relationship, :deleted_at]}
  validates :relationship, presence: true
end
