# frozen_string_literal: true

module Geometry
  # Base class for geometrical components
  class GeometricalBase < ViewComponent::Base
    include Scalable

    attr_reader :geometry

    def initialize(geometry:, **)
      super
      @geometry = geometry
      # @scale = scale&.to_f
      # @rounding = rounding
    end
  end
end
