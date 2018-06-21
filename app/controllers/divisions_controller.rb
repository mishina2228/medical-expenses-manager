class DivisionsController < ApplicationController
  def load_division_names
    begin
      klass = params[:klass].constantize
    rescue NameError
      render partial: 'partials/division_name_not_found', locals: {klass: params[:klass]}
      return
    end

    objects = klass.all.map {|o| [o.name, o.id]}
    render partial: 'partials/division_name', locals: {objects: objects}
  end
end
