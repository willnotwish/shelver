# frozen_string_literal: true

module Geometry
  # Adds the ability to scale and round dimensions
  module Scalable
    extend ActiveSupport::Concern

    # included do
    #   attr_reader :scale, :rounding
    # end

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

    def initialize(scale: 1, rounding: 1, **options)
      Rails.logger.debug "#{self.class.name}#initialize. scale: #{scale}, rounding: #{rounding}"
      super
      @scale = scale&.to_f
      @rounding = rounding
    end

    def before_render
      @scale ||= helpers.default_scale.to_f
    end

    def scaled?
      true
      # scale != 1
    end

    def scale
      @scale || 1
    end

    def rounding
      @rounding || 1
    end

    private

    def _scale(dimension)
      return nil if dimension.blank?

      dimension / scale
    end

    def _round(dimension)
      dimension&.round(rounding)
    end

    def scale_and_round(dimension)
      _round(_scale(dimension))
      # (dimension / scale).round(rounding)
    end
    alias sar scale_and_round
  end
end
