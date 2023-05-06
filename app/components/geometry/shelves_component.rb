# frozen_string_literal: true

module Geometry
  # Displays information about the shelving capacity of a geometry
  class ShelvesComponent < GeometricalBase
    include AreaConversions

    delegate :shelf_count, to: :geometry

    delegate_dimension :uniform_shelf_spacing, to: :geometry
    delegate_dimension :shelf_width, to: :geometry
    delegate_dimension :shelf_depth, to: :geometry
    delegate_dimension :shelf_opening, to: :geometry

    delegate :shelf_area, to: :geometry

    def total_shelf_area
      shelf_count * shelf_area
    end

    def description
      return "One shelf #{shelf_width.round(1)} x #{shelf_depth.round(1)}" if shelf_count == 1

      "#{shelf_count} shelves, each #{shelf_width.round(1)} x #{shelf_depth.round(1)}"
    end
  end
end
