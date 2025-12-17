# frozen_string_literal: true

class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.paginate(params)
  end

  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html {redirect_to people_url, notice: t('helpers.notice.create')}
        format.json {render :show, status: :created, location: @person}
      else
        format.html {render :new, status: :unprocessable_content}
        format.json {render json: @person.errors, status: :unprocessable_content}
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html {redirect_to people_url, notice: t('helpers.notice.update')}
        format.json {render :show, status: :ok, location: @person}
      else
        format.html {render :edit, status: :unprocessable_content}
        format.json {render json: @person.errors, status: :unprocessable_content}
      end
    end
  end

  def destroy
    @person.destroy
    respond_to do |format|
      format.html {redirect_to people_url, notice: t('helpers.notice.delete'), status: :see_other}
      format.json {head :no_content}
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.expect(person: [:name, :relationship])
  end
end
