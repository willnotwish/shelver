# frozen_string_literal: true

module Geometry
  # The simplest form of unit geometry. Expects a unit to be passed in as config,
  # rather than individual dimensions, of which there are many.
  class PlainUnit
    include HasBaseDimensions
    include HasUniformShelfSpacing
    include HasPanels

    alias unit_height height
    alias unit_width width
    alias unit_depth depth

    alias thickness_of_top sheet_thickness
    alias thickness_of_shelf sheet_thickness

    # Shelves
    def shelf_width
      unit_width - 2 * sheet_thickness
    end

    alias shelf_depth unit_depth # full-depth

    alias shelf_opening shelf_width

    def shelf_area
      shelf_width * shelf_depth
    end
    alias usable_shelf_area shelf_area
  end
end
