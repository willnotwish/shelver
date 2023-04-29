# frozen_string_literal: true

module Geometry
  # The simplest form of unit geometry. Expects a unit to be passed in as config,
  # rather than individual dimensions, of which there are many.
  class PlainUnit
    # include HasBoundingBox
    # include HasOffsets
    # include HasShelves
    
    attr_reader :height, :width, :depth
    attr_reader :offset_top, :offset_bottom
    attr_reader :shelf_count
    attr_reader :sheet_thickness

    def initialize(unit:, **)
      extract_outer_dimensions(unit)
      extract_offsets(unit)
      extract_shelf_details(unit)
      extract_material_thickness(unit)
    end

    alias unit_height height
    alias unit_width width
    alias unit_depth depth

    # Shelves are assumed to span front to back for now
    alias shelf_depth unit_depth

    def shelf_opening
      width - 2 * sheet_thickness
    end

    # Thickness
    alias thickness_of_top sheet_thickness
    alias thickness_of_shelf sheet_thickness

    def shelf_width
      unit_width - 2 * sheet_thickness
    end

    def shelf_area
      shelf_width * shelf_depth
    end

    alias usable_shelf_area shelf_area

    def sheet_area
      2 * (height * depth) + (shelf_count + 1) * shelf_area
    end
    alias sheet_material_used sheet_area

    def uniform_shelf_spacing
      (height - offset_top - offset_bottom - thickness_of_top) / shelf_count
    end

    def panels
      []
    end

    private

    def extract_outer_dimensions(unit)
      @height = unit.height
      @width = unit.width
      @depth = unit.depth
    end

    def extract_offsets(unit)
      @offset_bottom = unit.offset_bottom
      @offset_top = unit.offset_top
    end

    def extract_material_thickness(unit)
      @sheet_thickness = unit.sheet.thickness
    end

    def extract_shelf_details(unit)
      @shelf_count = unit.shelf_count
    end
  end
end
