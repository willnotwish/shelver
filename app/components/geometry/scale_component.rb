# frozen_string_literal: true

module Geometry
  # Render the scale currently in use, if one is set
  class ScaleComponent < ViewComponent::Base
    attr_reader :scale

    def initialize(scale:, **)
      super
      @scale = scale
    end

    NO_SCALING = 1

    def render?
      scale != NO_SCALING
    end
  end
end
