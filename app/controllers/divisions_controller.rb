class DivisionsController < ApplicationController
  def load_division_names
    objects = Division.all_records(params[:klass])
    render json: objects
  end
end
