# frozen_string_literal: true

module Units
  # A preview of a unit
  class PreviewComponent < ViewComponent::Base
    with_collection_parameter :geometry

    attr_reader :geometry, :label_prefix

    def initialize(geometry:, label_prefix: 'SET_ME', scaling_factor: 3.0)
      super
      @geometry = geometry
      @label_prefix = label_prefix
      @scaling_factor = scaling_factor
    end

    delegate :shelf_count, to: :geometry
    delegate :code, to: :unit, prefix: true

    def shelf_label(index)
      "#{label_prefix}.S#{shelf_count - index}"
    end

    def top_label
      "#{label_prefix}.T"
    end

    def dynamic_unit_style
      "width: #{scale(geometry.unit_width)}px"
    end

    def dynamic_style(kind: :shelf)
      height =
        case kind
        when :shelf
          shelf_void_height
        when :top_void
          geometry.offset_top
        when :bottom_void
          geometry.offset_bottom
        end

      "height: #{scale(height)}px"
    end

    def shelf_void_height
      geometry.uniform_shelf_spacing - geometry.sheet_thickness
    end

    private

    def scale(length)
      length/@scaling_factor
    end
  end
end
