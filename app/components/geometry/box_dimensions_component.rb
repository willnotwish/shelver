# frozen_string_literal: true

module Geometry
  # Displays box dimensions: width, height and depth
  class BoxDimensionsComponent < ViewComponent::Base
    include Scalable

    attr_reader :box

    def initialize(box:, scale: nil, rounding: 1, **)
      super
      @box = box
      @scale = scale&.to_f
      @rounding = rounding
    end

    delegate :width, :height, :depth, to: :box, prefix: :actual

    delegate_dimension :width, to: :box, as: :scaled_width
    delegate_dimension :height, to: :box, as: :scaled_height
    delegate_dimension :depth, to: :box, as: :scaled_depth
  end
end
