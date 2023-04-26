class CompositesController < ApplicationController
  def index
    @composites = Composite.all
  end

  def show
    @composite = Composite.find params[:id]
  end

  def new
  end

  def edit
  end

  def destroy
  end
end
