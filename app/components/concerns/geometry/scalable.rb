# frozen_string_literal: true

module Geometry
  # Adds the ability to scale and round dimensions
  module Scalable
    extend ActiveSupport::Concern

    included do
      attr_reader :scale, :rounding
    end

    class_methods do
      def delegate_dimension(attribute, to:, as: nil, scale_and_round: true)
        define_method(as || attribute) do
          source = send(to)
          value = source&.send(attribute)
          if scale_and_round && value
            sar(value)
          else
            value
          end
        end
      end
    end

    def before_render
      @scale ||= helpers.default_scale.to_f
    end

    def scaled?
      scale != 1
    end

    private

    def scale_and_round(dimension)
      (dimension / (scale || 1)).round(rounding || 1)
    end
    alias sar scale_and_round
  end
end
