# frozen_string_literal: true

# Preview drawing of composite
class CompositePreviewComponent < ViewComponent::Base
  attr_reader :geometries

  def initialize(geometries:, scale: 0.4)
    super
    @geometries = geometries
    @scale = scale
  end

  def container_tag_data
    {
      controller: 'unit-preview-canvas',
      unit_preview_canvas_target: 'canvas',
      unit_preview_canvas_groups_value:,
      unit_preview_canvas_scale_value:,
      unit_preview_canvas_bounding_box_value:,
      unit_preview_canvas_margins_value:,
      unit_preview_canvas_constraints_value:
    }
  end

  def container_style
    'height: 1200px; width: 1200px'
  end

  private

  def unit_preview_canvas_scale_value
    @scale
  end

  def unit_preview_canvas_margins_value
    { top: 180, left: 200, bottom: 20, right: 80 }
  end

  def unit_preview_canvas_constraints_value
    cupboard_door = Konva::Rect.new(
      name: 'Cupboard door',
      width: 600,
      height: 1800,
      x: 0,
      y: 2250 - 1800
    )

    desk = Konva::Rect.new(
      name: 'Desk',
      width: 1500,
      height: 850,
      x: 1200,
      y: 2250 - 850
    )

    [cupboard_door, desk]
  end

  def unit_preview_canvas_bounding_box_value
    bounds = Geometry::BoundingBox.new(geometries:)
    Konva::Rect.new(
      name: 'Bounding box',
      width: bounds.width,
      height: bounds.height
    )
  end

  def unit_preview_canvas_groups_value
    # separation = 200
    # x = 0
    # y = 0
    # groups = [Konva::Group.new(x:, y:, name: 'Top view', rects: geometry.top_view)]

    # y += geometry.top_view_bounding_box.last + separation
    # groups << Konva::Group.new(x:, y:, name: 'Front elevation', rects: geometry.front_elevation)

    # x += geometry.front_elevation_bounding_box.first + separation
    # groups << Konva::Group.new(x:, y:, name: 'Side elevation', rects: geometry.side_elevation)

    x = 0
    y = 0

    groups = []

    # Front elevation only for now
    geometries.each do |geometry|
      groups << Konva::Group.new(x:, y:, name: nil, rects: geometry.front_elevation)
      bounds = geometry.top_view_bounding_box
      x += bounds.first
    end

    groups
  end
end
