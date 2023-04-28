# frozen_string_literal: true

module Units
  # Displays sheet material needed to construct a unit
  class SheetMaterialComponent < ViewComponent::Base
    include LinkTo
    include AreaConversions

    attr_reader :geometry, :sheet_material

    def initialize(sheet_material:, geometry:, **)
      super
      @sheet_material = sheet_material
      @geometry = geometry
    end

    delegate :shelf_area,
             :shelf_count, :total_shelf_area,
             :uniform_shelf_spacing,
             :sheet_material_used, to: :geometry

    def minimum_number_of_sheets_needed
      sheet_usage.round(2)
    end

    def sheet_usage
      area_of_sheet = sheet_material.width * sheet_material.length
      sheet_material_used.to_f / area_of_sheet
    end

    def shelf_width
      geometry.shelf_width.round(1)
    end

    def shelf_depth
      geometry.shelf_depth.round(1)
    end

    def side_height
      geometry.unit_height.round(1)
    end

    def side_depth
      geometry.unit_depth.round(1)
    end
  end
end
