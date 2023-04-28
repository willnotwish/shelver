# frozen_string_literal: true

module Units
  # Common base class for all unit components
  class BaseComponent < ViewComponent::Base
    attr_reader :unit, :geometry

    def initialize(unit: nil, geometry: nil, **)
      super

      @unit = unit
      @geometry = geometry
    end

    delegate :kind, :sheet, to: :unit, prefix: true
    delegate :thickness, to: :sheet, prefix: true
  end
end
