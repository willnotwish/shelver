# frozen_string_literal: true

module Geometry
  # A base for all unit geometries
  class BaseUnit
    attr_reader :unit

    def initialize(unit:)
      @unit = unit
    end

    # Contains delegated readers only (no calculations)
    delegate :shelf_count, :offset_top, :offset_bottom, :sheet, to: :unit
    delegate :thickness, to: :sheet, prefix: true

    def uniform_shelf_spacing
      (unit.height - ((shelf_count + 1) * sheet_thickness + offset_top + offset_bottom)) / shelf_count
    end
  end
end
