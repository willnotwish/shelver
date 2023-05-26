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

    def left_side?
      false
    end

    def right_side?
      true
    end

    # Technical drawings

    # Returns an array of Konva rectangles
    def front_elevation
      x = 0
      # y = 0
      # lhs = Konva::Rect.new(x:, y:, width: sheet_thickness, height:)

      # x += sheet_thickness
      y = offset_top
      top = Konva::Rect.new(x:, y:, width: shelf_width, height: sheet_thickness)

      delta = uniform_shelf_spacing
      shelves = shelf_count.times.map do
        Konva::Rect.new(x:, y: y += delta, width: shelf_width, height: sheet_thickness)
      end

      x += shelf_width
      rhs = Konva::Rect.new(x:, y: 0, width: sheet_thickness, height:)

      [top, shelves, rhs].flatten
    end

    def front_elevation_bounding_box
      [width, height]
    end

    def top_view
      x = 0
      y = 0
      lhs = top_rect(x:, y:, width: sheet_thickness)

      x += sheet_thickness
      top = top_rect(x:, y:, width: shelf_width)

      x += shelf_width
      y = 0
      rhs = top_rect(x:, y:, width: sheet_thickness)

      [lhs, top, rhs]
    end

    def top_rect(height: depth, **attrs)
      Konva::Rect.new(height:, **attrs)
    end

    def top_view_bounding_box
      [width, depth]
    end

    def side_elevation
      y = 0
      rhs = side_rect(y:, height:)
      top = side_rect(y: y += offset_top, height: sheet_thickness, dash: [10, 5])

      y0 = uniform_shelf_spacing
      shelves = shelf_count.times.map do
        side_rect(y: y += y0, height: sheet_thickness, dash: [10, 5])
      end

      [rhs, top, shelves].flatten
    end

    def side_rect(width: depth, **attrs)
      Konva::Rect.new(x: 0, width:, **attrs)
    end

    def side_elevation_bounding_box
      [depth, height]
    end

    private

    def shelf_width_and_depth
      @width_and_depth ||= width - sheet_thickness
    end

    def cutout
      @cutout ||= width - sheet_thickness - depth # aka "x"
    end
  end
end
