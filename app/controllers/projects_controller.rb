# frozen_string_literal: true

# RESTful Project actions
class ProjectsController < ApplicationController
  include HasScaling

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find params[:id]
  end
end
