# frozen_string_literal: true

# Preview drawing of unit with given geometry
class UnitPreviewComponent < ViewComponent::Base
  attr_reader :unit, :geometry, :scale

  def initialize(unit:, geometry: nil, scale: 2.0)
    super
    @unit = unit
    @geometry = geometry
    @scale = scale
  end

  def panels
    @panels ||= PanelBuilder.panels_for([unit])
  end

  def container_tag_data
    {
      controller: 'unit-preview-canvas',
      unit_preview_canvas_target: 'canvas',
      unit_preview_canvas_groups_value: konva_groups
    }
  end

  def container_style
    'height: 2500px; width: 1000px'
  end

  private

  def before_render
    return if @geometry

    @geometry = helpers.unit_geometry(unit:)
  end

  def konva_groups
    top = geometry.top_view_bounding_box.map { |d| d / scale }
    front = geometry.front_elevation_bounding_box.map { |d| d / scale }

    padding = 50
    separation = 100

    x = padding
    y = padding

    top_group = Konva::Group.new(
      x:,
      y:,
      name: 'Top view',
      rects: geometry.top_view.map { |rect| rect.scale(scale:) }
    )

    y += top.last + separation
    front_group = Konva::Group.new(
      x:,
      y:,
      name: 'Front elevation',
      rects: geometry.front_elevation.map { |rect| rect.scale(scale:) }
    )

    x += front.first + separation

    side_group = Konva::Group.new(
      x:,
      y:,
      name: 'Side elevation',
      rects: geometry.side_elevation.map { |rect| rect.scale(scale:) }
    )

    [top_group, front_group, side_group]
  end
end
