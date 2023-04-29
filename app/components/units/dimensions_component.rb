# frozen_string_literal: true

module Units
  # Displays the outer (overall, or max) dimensions of a unit
  class DimensionsComponent < ViewComponent::Base
    attr_reader :geometry

    def initialize(geometry:, **)
      super
      @geometry = geometry
    end

    delegate :unit_width, :unit_height, :unit_depth, :offset_top, :offset_bottom,
             :shelf_opening, to: :geometry
  end
end
