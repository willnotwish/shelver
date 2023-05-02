# frozen_string_literal: true

# Limited actions to generate a cutting list for CSV export
class PanelsController < ApplicationController
  # Nested under project, composite or unit
  def index
    if params[:project_id].present?
      @parent = Project.find(params[:project_id])
      @units = @parent.units
    elsif params[:composite_id].present?
      @parent = Composite.find(params[:composite_id])
      @units = @parent.units
    elsif params[:unit_id].present?
      @units = Unit.where(id: params[:unit_id])
    end
    @panels = PanelBuilder.panels_for(@units)

    respond_to do |format|
      format.html
      format.csv
    end
  end
end
