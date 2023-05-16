# frozen_string_literal: true

module Geometry
  # A preview of a geometry
  class PreviewComponent < ViewComponent::Base
    include Scalable

    with_collection_parameter :geometry

    attr_reader :geometry, :label_prefix

    def initialize(geometry:, label_prefix: 'SET_ME', css_scaling_factor: 3.0)
      super
      @geometry = geometry
      @label_prefix = label_prefix
      @css_scaling_factor = css_scaling_factor
    end

    delegate :shelf_count, :left_side?, :right_side?, to: :geometry

    def shelf_label(index)
      "#{label_prefix}.S#{shelf_count - index}"
    end

    def top_label
      "#{label_prefix}.T"
    end

    def top_width
      scale_and_round(geometry.unit_width)
    end

    def dynamic_unit_style
      properties = ["width: #{css_scale(geometry.unit_width)}px"]
      properties << 'padding-right: 0.5rem' if right_side?
      properties << 'padding-left: 0.5rem' if left_side?
      properties.join('; ')
    end

    def dynamic_style(kind: :shelf, index: nil)
      height =
        case kind
        when :shelf
          shelf_void_height(index)
        when :top_void
          geometry.offset_top
        when :bottom_void
          geometry.offset_bottom
        end

      "height: #{css_scale(height)}px"
    end

    def shelf_void_height(_index)
      geometry.uniform_shelf_spacing - geometry.sheet_thickness
    end

    def shelf_y_pos(index)
      h0 = geometry.offset_top
      pos = h0 + (geometry.uniform_shelf_spacing * (index + 1))
      scale_and_round(pos)
    end

    private

    def css_scale(length)
      length / @css_scaling_factor
    end
  end
end
