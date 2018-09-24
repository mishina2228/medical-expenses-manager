class DivisionsController < ApplicationController
  def load_division_names
    objects = params[:klass].present? ? params[:klass].constantize.all.map {|o| [o.name, o.id]} : {}
    name = case params[:name]
           when 'search'
             :search_record
           when 'new', 'edit', 'create', 'update'
             :record
           end
    render partial: 'records/division_name', locals: {objects: objects, name: name}
  end
end
