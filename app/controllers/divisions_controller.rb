class DivisionsController < ApplicationController
  def load_division_names
    objects = if params[:klass].blank?
                {}
              else
                klass = params[:klass].constantize
                klass.all.map {|o| [o.name, o.id]}
              end
    name = case params[:name]
           when 'search'
             :search_record
           when 'new', 'edit'
             :record
           end
    render partial: 'records/division_name', locals: {objects: objects, name: name}
  end
end
