# frozen_string_literal: true

# Limited actions to generate a cutting list for display or CSV export
class PanelsController < ApplicationController
  def index
    find_units # may be nested under project, composite, unit
    @panels = PanelBuilder.panels_for(@units)

    respond_to do |format|
      format.html
      format.csv
    end
  end

  private

  def find_units
    identify_parent
    @units = @parent&.units
    @units ||= Unit.where(id: params[:unit_id]) if params[:unit_id].present?
    @units ||= Unit.all
  end

  def identify_parent
    @parent = 
      if params[:project_id].present?
        Project.find(params[:project_id])
      elsif params[:composite_id].present?
        Composite.find(params[:composite_id])
      end
  end
end
