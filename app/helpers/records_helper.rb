# frozen_string_literal: true

module RecordsHelper
  def render_division(division)
    emoji = case division
            when Drugstore
              ':pill:'
            when Transport
              ':train:'
            when Hospital
              ':hospital:'
            end
    [emoji, division.model_name.human].join
  end
end
