# frozen_string_literal: true

# Preview drawing of unit with given geometry
class UnitPreviewComponent < ViewComponent::Base
  attr_reader :geometry, :scale

  def initialize(geometry:, scale: 0.4)
    super
    @geometry = geometry
    @scale = scale
  end

  def container_tag_data
    {
      controller: 'unit-preview-canvas',
      unit_preview_canvas_target: 'canvas',
      unit_preview_canvas_groups_value: konva_groups,
      unit_preview_canvas_scale_value: scale
    }
  end

  def container_style
    'height: 1200px; width: 1000px'
  end

  private

  def konva_groups
    separation = 200
    x = 0
    y = 0
    groups = [Konva::Group.new(x:, y:, name: 'Top view', rects: geometry.top_view)]

    y += geometry.top_view_bounding_box.last + separation
    groups << Konva::Group.new(x:, y:, name: 'Front elevation', rects: geometry.front_elevation)

    x += geometry.front_elevation_bounding_box.first + separation
    groups << Konva::Group.new(x:, y:, name: 'Side elevation', rects: geometry.side_elevation)

    groups
  end
end
