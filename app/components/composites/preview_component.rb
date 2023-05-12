# frozen_string_literal: true

module Composites
  # Shows a preview of the given composite
  class PreviewComponent < ViewComponent::Base
    attr_reader :composite

    def initialize(composite:, x_scale: true)
      super
      @composite = composite
      @x_scale = x_scale
    end

    delegate :units, to: :composite

    def geometry_of(unit)
      helpers.unit_geometry(unit:)
    end

    def show_x_scale?
      !!@x_scale
    end
  end
end
