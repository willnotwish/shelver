# frozen_string_literal: true

module Composites
  class CuttingListComponent < ViewComponent::Base
    attr_reader :composite

    def initialize(composite:)
      @composite = composite
    end

    # Returns an array of panels
    def panels
      @panels ||= self.class.panels_from_composite(composite)
    end

    def quantified_panels
      @quantified_panels ||= self.class.quantify_panels(panels) 
    end

    class Size
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

      def to_a
        [x, y]
      end
    
      def eql?(other)
        (x == other.x && y == other.y) || (x == other.y && y == other.x)
      end
    
      def hash
        to_a.hash
      end

      def to_s
        [to_a.max, to_a.min].join(' x ')
      end
    end

    class << self
      # Returns a hash:
      # {
      #   [300, 200] => 4,  # 4 off 300 x 200
      #   [1220, 300] => 2
      # }
      def quantify_panels(panels)
        hash = {}
        panels.each do |panel|
          size = Size.new(panel.x, panel.y)
          hash[size] ||= 0
          hash[size] += 1
        end
        hash
      end

      def panels_from_composite(composite)
        composite.units.map do |unit|
          sheet = unit.sheet

          # Sides
          x = unit.height
          y = unit.depth
          label = "#{unit.code}.L"
          description = "Left side of unit #{unit.code}"
          left_side = Panel.new(sheet:, x:, y:, label:, description:)
          
          label = "#{unit.code}.R"
          description = "Right side of unit #{unit.code}"
          right_side = Panel.new(sheet:, x:, y:, label:, description:)

          # Shelves
          x = unit.depth
          y = unit.width - 2 * sheet.thickness
          shelves = []
          unit.shelf_count.times do |i|
            label = "#{unit.code}.S#{i+1}"
            description = "Shelf #{i+1} of unit #{unit.code}"
            shelf = Panel.new(sheet:, x:, y:, label:, description:)
            shelves << shelf
          end

          # Top
          label = "#{unit.code}.T"
          description = "Top of unit #{unit.code}"
          top = Panel.new(sheet:, x:, y:, label:, description:)

          [left_side, right_side, shelves, top].flatten

        end.flatten.compact
      end
    end
  end
end
