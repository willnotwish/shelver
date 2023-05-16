# frozen_string_literal: true

module Konva
  # Models a rectangle in Konva.js
  class Rect
    include ActiveModel::Serializers::JSON

    attr_accessor :width, :height, :x, :y, :options

    def initialize(width:, height:, x: 0, y: 0, **options)
      @width = width
      @height = height
      @x = x
      @y = y
      @options = options.stringify_keys
    end

    def attributes
      options.merge('x' => x, 'y' => y, 'width' => width, 'height' => height)
    end

    def scale(scale: nil, **)
      return self unless scale

      scaled_dimensions = {
        width: width / scale,
        height: height / scale,
        x: x / scale,
        y: y / scale
      }

      self.class.new(**options.merge(scaled_dimensions))
    end

    # def move(offset_x: nil, offset_y: nil, **)
    #   return self unless offset_x || offset_y

    #   shifted_x = x
    #   shifted_x += offset_x if offset_x
    #   shifted_y = y
    #   shifted_y += offset_y if offset_y
    #   self.class.new(x: shifted_x, y: shifted_y, width:, height:)
    # end

    class << self
      def transform_all(rectangles, **options)
        rectangles.map do |rect|
          rect.scale(**options)
        end
      end
    end

    private

    def read_attribute_for_serialization(key)
      return super if %w[x y width height].include?(key)

      options[key]
    end
  end
end
