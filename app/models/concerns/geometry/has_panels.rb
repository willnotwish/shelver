# frozen_string_literal: true

module Geometry
  module HasPanels
    def side_panel_dimensions
      [height, depth]
    end

    def shelf_panel_dimensions
      [shelf_width, shelf_depth]
    end
    alias top_panel_dimensions shelf_panel_dimensions

    def panel_area
      side = _a(side_panel_dimensions)
      top = _a(top_panel_dimensions)
      shelf = _a(shelf_panel_dimensions)
      2 * side + top + shelf_count * shelf
    end
    alias sheet_material_used panel_area
    alias sheet_area panel_area

    private

    def _a(dimensions)
      dimensions.first * dimensions.last
    end
  end
end
