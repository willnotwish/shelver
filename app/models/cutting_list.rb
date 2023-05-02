class CuttingList
  attr_reader :composite

  def initialize(composite:)
    @composite = composite
  end

  def panels
    @panels ||= composite.units.map { |unit| self.class.unit_panels(unit) }.flatten
  end

  class << self
    def composite_panels(composite:, **)
      composite.units.map { |unit| self.class.unit_panels(unit) }.flatten
    end

    def unit_panels(unit)
      prefix = unit.code
      geometry = unit_geometry(unit:)

      # Sides: 2 off height x depth
      left_side = Panel.new(x: unit.height, y: unit.depth, label: "#{prefix}-LHS")
      right_side = Panel.new(x: unit.height, y: unit.depth, label: "#{prefix}-RHS")

      # Shelves
      shelves = unit.shelf_count.times.map do
        Panel.new(x: unit.shelf_width, y: unit.shelf_depth, label: "#{prefix}-S")
      end

      top = Panel.new(x: unit.shelf_width, y: unit.shelf_depth, label: "#{prefix}-T")
      [left_side, right_side, shelves, top]
    end
  end
end
