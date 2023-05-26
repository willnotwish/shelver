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
    alias usable_shelf_area shelf_area # all the shelf is usable

    def left_side?
      true
    end

    def right_side?
      true
    end

    # Technical drawings

    # Returns an array of Konva rectangles
    def front_elevation
      rects = [Konva::Rect.new(x: 0, y: 0, width: sheet_thickness, height:)]

      x = sheet_thickness
      y = offset_top
      rects << Konva::Rect.new(x:, y:, width: shelf_width, height: sheet_thickness)

      # void_height = uniform_shelf_spacing
      shelf_count.times do
        rects << Konva::Rect.new(x:, y: y += uniform_shelf_spacing, width: shelf_width, height: sheet_thickness)
      end

      rects << Konva::Rect.new(x: x + shelf_width, y: 0, width: sheet_thickness, height:)
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
  end
end
