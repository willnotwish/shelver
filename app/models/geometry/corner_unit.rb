# frozen_string_literal: true

module Geometry
  # Models the geometry of a corner unit, intended to join
  # two plain units at right angles in an internal corner
  class CornerUnit
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

    # Dimensions
    alias unit_height height
    alias unit_width width
    alias unit_depth width

    def opening
      Math.sqrt(2.0 * cutout * cutout)
    end

    alias thickness_of_top sheet_thickness
    alias thickness_of_shelf sheet_thickness

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

    def uniform_shelf_spacing
      (height - offset_top - offset_bottom - thickness_of_top) / shelf_count
    end

    # Raw material
    def sheet_area
      sides = 2 * height * depth
      shelf = shelf_width_and_depth * shelf_width_and_depth
      shelves_and_top = (shelf_count + 1) * shelf
      sides + shelves_and_top
    end
    alias sheet_material_used sheet_area

    private

    def shelf_width_and_depth
      @width_and_depth ||= width - sheet_thickness
    end

    def cutout      
      @cutout ||= width - sheet_thickness - depth # aka "x"
    end

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
