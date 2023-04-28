# frozen_string_literal: true

# RESTful Composite actions
class CompositesController < ApplicationController
  include UnitGeometry

  def index
    @composites = Composite.all
  end

  def show
    @composite = Composite.find params[:id]
  end

  def new; end

  def edit; end

  def destroy; end
end
