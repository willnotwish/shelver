# frozen_string_literal: true

module Units
  class PreviewComponent < BaseComponent
    def initialize(unit:, scaling_factor: 3.0)
      super
      @scaling_factor = scaling_factor
    end

    delegate :shelf_count, to: :unit
    delegate :code, to: :unit, prefix: true

    def dynamic_unit_style
      "width: #{scale(unit.width)}px"
    end

    def dynamic_style(kind: :shelf)
      height = 
        if kind == :shelf
          shelf_void_height
        elsif kind == :top_void
          unit.offset_top
        elsif kind == :bottom_void
          unit.offset_bottom
        end  

      "height: #{scale(height)}px"
    end

    def shelf_void_height
      unit.uniform_shelf_spacing - unit.sheet.thickness
    end

    private

    def scale(length)
      length/@scaling_factor
    end
  end
end
