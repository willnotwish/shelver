class PanelsController < ApplicationController
  def index
    @composite = Composite.find params[:composite_id]
    @panels = PanelBuilder.panels_from_composite(@composite)
    @quantified_panels = PanelsQuantifier.quantify(@panels)
    @sheet = @panels.first.sheet

    respond_to do |format|
      format.html
      format.csv
    end
  end
end
