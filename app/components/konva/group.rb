# frozen_string_literal: true

module Konva
  # Models a Konva.js group
  class Group
    attr_accessor :name, :x, :y, :rects

    def initialize(name:, rects:, x: 0, y: 0)
      @name = name
      @x = x
      @y = y
      @rects = rects
    end

    def move(offset_x: nil, offset_y: nil, **)
      return self unless offset_x || offset_y

      shifted_x = x
      shifted_x += offset_x if offset_x
      shifted_y = y
      shifted_y += offset_y if offset_y
      self.class.new(x: shifted_x, y: shifted_y, name:)
    end

    class << self
      def transform_all(rectangles, **options)
        rectangles.map do |rect|
          rect.move(**options)
        end
      end
    end
  end
end
