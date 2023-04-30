# frozen_string_literal: true

module Units
  # Displays information about the shelving capacity of a unit
  class ShelvesComponent < ViewComponent::Base
    include AreaConversions

    attr_reader :geometry

    def initialize(geometry:, **)
      super
      @geometry = geometry
    end

    delegate :shelf_count,
             :uniform_shelf_spacing,
             :shelf_width, :shelf_depth, :shelf_area, to: :geometry

    def total_shelf_area
      shelf_count * shelf_area
    end

    def description
      return "One shelf #{shelf_width.round(1)} x #{shelf_depth.round(1)}" if shelf_count == 1
     
      "#{shelf_count} shelves, each #{shelf_width.round(1)} x #{shelf_depth.round(1)}"
    end
  end
end
