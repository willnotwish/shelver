# frozen_string_literal: true

class Projects::OverviewComponent < ViewComponent::Base
  include LinkTo
  
  attr_reader :project

  def initialize(project:, **)
    @project = project
  end

  delegate :name, :description, to: :project, prefix: true

  def show_name?
    false
  end

  def composite_count
    project.composites.count
  end

  def unit_count
    project.units.count
  end
end
