# frozen_string_literal: true

# Preview drawing of composite
class CompositePreviewComponent < ViewComponent::Base
  attr_reader :geometries, :scale

  def initialize(geometries:, scale: 0.4)
    super
    @geometries = geometries
    @scale = scale
  end

  def container_tag_data
    {
      controller: 'unit-preview-canvas',
      unit_preview_canvas_target: 'canvas',
      unit_preview_canvas_groups_value: konva_groups,
      unit_preview_canvas_scale_value: scale,
      unit_preview_canvas_bounding_box_value: konva_bounding_box
    }
  end

  def container_style
    'height: 1200px; width: 1200px'
  end

  private

  def konva_bounding_box
    bounding_box = Geometry::BoundingBox.new(geometries:)
    rect = Konva::Rect.new(
      name: 'Bounding box',
      width: bounding_box.width,
      height: bounding_box.height,
      x: 20,
      y: 20
    )

    options = { foo: :bar, x_axis: true, y_axis: false }
    options.merge(rect:)
  end

  def konva_groups
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
