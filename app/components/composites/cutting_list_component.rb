# frozen_string_literal: true

module Composites
  class CuttingListComponent < ViewComponent::Base
    attr_reader :composite

    def initialize(composite:, show_individual_panels: false)
      @composite = composite
      @show_individual_panels = show_individual_panels
    end

    def show_individual_panels?
      @show_individual_panels
    end

    # Returns an array of panels
    def panels
      @panels ||= panels_from_composite(composite)
    end

    def panels_from_composite(composite)
      composite.units.map do |unit|
        self.class.build_panels(
          unit_code: unit.code,
          sheet: unit.sheet,
          geometry: helpers.unit_geometry(unit:),
          shelf_count: unit.shelf_count
        )
      end.flatten.compact
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
    
      # A PanelBuilder class might be better
      def build_panels(unit_code:, geometry:, sheet:, shelf_count:)
        dimensions = geometry.side_panel_dimensions
        lhs = build_panel(dimensions:, sheet:,
                          label: "#{unit_code}.L",
                          description: "Left side of unit #{unit_code}")

        rhs = build_panel(dimensions:, sheet:,
                          label: "#{unit_code}.R",
                          description: "Right side of unit #{unit_code}")

        # Shelves
        dimensions = geometry.shelf_panel_dimensions
        shelves = shelf_count.times.map.with_index do |i|
          build_panel(dimensions:, sheet:,
                      label: "#{unit_code}.S#{i+1}",
                      description: "Shelf #{i+1} of unit #{unit_code}")
        end

        dimensions = geometry.top_panel_dimensions
        top = build_panel(dimensions:, sheet:,
                          label: "#{unit_code}.T",
                          description: "Top of unit #{unit_code}")

        [lhs, rhs, shelves, top].flatten
      end

      def build_panel(dimensions:, **panel_attrs)
        x, y = order(dimensions)
        Panel.new(panel_attrs.merge(x:, y:))
      end

      def order(dimensions)
        x, y = dimensions
        return [x, y] if x >= y

        [y, x]
      end
    end
  end
end
