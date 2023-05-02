# frozen_string_literal: true

module Geometry
  module HasBaseDimensions
    extend ActiveSupport::Concern

    included do
      attr_reader :height, :width, :depth
      attr_reader :offset_top, :offset_bottom
      attr_reader :shelf_count
      attr_reader :sheet_thickness
    end

    def initialize(unit:, **)
      extract_outer_dimensions(unit)
      extract_offsets(unit)
      extract_shelf_details(unit)
      extract_material_thickness(unit)
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