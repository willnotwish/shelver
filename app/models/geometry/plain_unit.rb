# frozen_string_literal: true

module Geometry
  # The simplest form of unit geometry
  class PlainUnit < BaseUnit
    delegate :height, :depth, :width, to: :unit, prefix: true

    # Shelves are assumed to span front to back for now
    alias shelf_depth unit_depth

    def shelf_width
      unit_width - 2 * sheet_thickness
    end

    def shelf_area
      shelf_width * shelf_depth
    end

    alias usable_shelf_area shelf_area

    def sheet_material_used
      2 * (unit.height * unit.depth) + (unit.shelf_count + 1) * shelf_area
    end
  end
end
