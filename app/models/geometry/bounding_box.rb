# frozen_string_literal: true

module Geometry
  # Units are placed side by side (horizontally, along the x-axis)
  class BoundingBox
    attr_reader :geometries

    def initialize(geometries:, **)
      @geometries = geometries
    end

    def x
      geometries.map(&:unit_width).reduce(0) { |total, width| total + width }
    end
    alias width x

    def y
      geometries.map(&:unit_height).max
    end
    alias height y

    def z
      geometries.map(&:unit_depth).max
    end
    alias depth z
  end
end
