# frozen_string_literal: true

module Geometry
  # Models the geometry of a corner unit
  class CornerUnit < BaseUnit
    def unit_width
      width_and_depth + sheet_thickness
    end

    def unit_depth
      width_and_depth + sheet_thickness
    end

    # unit_height
    delegate :height, to: :unit, prefix: true

    def shelf_width
      width_and_depth
    end

    def shelf_depth
      width_and_depth
    end

    def shelf_area
      (width_and_depth * width_and_depth) - (0.5 * cutout * cutout)
    end
    alias usable_shelf_area shelf_area

    def sheet_material_used
      sides = 2 * unit.height * unit.depth
      shelf = width_and_depth * width_and_depth
      shelves_and_top = (shelf_count + 1) * shelf
      sides + shelves_and_top
    end

    private

    def opening
      unit.width
    end

    def width_and_depth
      @width_and_depth ||= unit.depth + cutout
    end

    def cutout
      # aka "x"
      @cutout ||= Math.sqrt(0.5 * opening * opening)
    end
  end
end
