# frozen_string_literal: true

module Geometry
  # Displays the outer (overall, or max) dimensions of a geometrical design
  class DimensionsComponent < GeometricalBase
    delegate_dimension :offset_top, to: :geometry
    delegate_dimension :offset_bottom, to: :geometry

    delegate_dimension :unit_width, to: :geometry, as: :bounding_box_width
    delegate_dimension :unit_height, to: :geometry, as: :bounding_box_height
    delegate_dimension :unit_depth, to: :geometry, as: :bounding_box_depth
  end
end
