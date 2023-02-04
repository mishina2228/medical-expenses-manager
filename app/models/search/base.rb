# frozen_string_literal: true

module Search
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations::Callbacks
  end
end
