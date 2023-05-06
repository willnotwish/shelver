# frozen_string_literal: true

module Geometry
  # Displays sheet material needed to construct a unit
  class SheetMaterialComponent < GeometricalBase
    include LinkTo
    include AreaConversions

    attr_reader :sheet_material

    def initialize(sheet_material:, **)
      super
      @sheet_material = sheet_material
    end

    delegate :shelf_count, to: :geometry

    delegate_dimension :uniform_shelf_spacing, to: :geometry
    delegate_dimension :shelf_width, to: :geometry
    delegate_dimension :shelf_depth, to: :geometry
    delegate_dimension :unit_height, to: :geometry, as: :side_height
    delegate_dimension :unit_depth, to: :geometry, as: :side_depth

    def minimum_number_of_sheets_needed
      area = sheet_material.width * sheet_material.length
      usage = geometry.sheet_material_used.to_f / area
      usage.round(2)
    end
  end
end
