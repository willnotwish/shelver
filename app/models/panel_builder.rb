class PanelBuilder
  include ApplicationHelper

  attr_reader :composite

  def initialize(composite:)
    @composite = composite
  end

  def panels
    @panels ||= build_panels
  end

  class << self
    def panels_from_composite(composite)
      new(composite:).panels
    end
  end
  
  private

  def build_panels
    composite.units.map do |unit|
      self.class.build_unit_panels(
        unit_code: unit.code,
        sheet: unit.sheet,
        geometry: unit_geometry(unit:),
        shelf_count: unit.shelf_count
      )
    end.flatten.compact
  end

  class << self
    def build_unit_panels(unit_code:, geometry:, sheet:, shelf_count:)
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
