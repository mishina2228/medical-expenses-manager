# frozen_string_literal: true

json.array! @hospitals, partial: 'hospitals/hospital', as: :hospital
