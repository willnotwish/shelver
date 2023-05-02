# frozen_string_literal: true

module Geometry
  # Models the geometry of a corner unit, intended to join
  # two plain units at right angles in an internal corner
  class CornerUnit
    include HasBaseDimensions
    include HasUniformShelfSpacing
    include HasPanels

    # Dimensions
    alias unit_height height
    alias unit_width width
    alias unit_depth width

    alias thickness_of_top sheet_thickness
    alias thickness_of_shelf sheet_thickness

    def opening
      Math.sqrt(2.0 * cutout * cutout)
    end

    # Shelves
    def shelf_width
      shelf_width_and_depth
    end

    def shelf_depth
      shelf_width_and_depth
    end

    alias shelf_opening opening

    def shelf_area
      (shelf_width_and_depth * shelf_width_and_depth) - (0.5 * cutout * cutout)
    end
    alias usable_shelf_area shelf_area

    private

    def shelf_width_and_depth
      @width_and_depth ||= width - sheet_thickness
    end

    def cutout      
      @cutout ||= width - sheet_thickness - depth # aka "x"
    end
  end
end
