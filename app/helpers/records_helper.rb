module RecordsHelper
  def render_division(division)
    emoji = case division.class.to_s
            when Drugstore.to_s
              ':pill:'
            when Transport.to_s
              ':train:'
            when Hospital.to_s
              ':hospital:'
            end
    [emoji, division.model_name.human].join
  end
end
