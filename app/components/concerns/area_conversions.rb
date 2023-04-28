# frozen_string_literal: true

# Tailwind helper module for links
module AreaConversions
  extend ActiveSupport::Concern

  def to_sq_m(*args)
    self.class.to_sq_m(*args)
  end

  class_methods do
    def to_square_metres(area, precision: 2)
      value = area / (1000.0 * 1000.0)
      "#{value.round(precision)} sq m"
    end

    alias_method :to_sq_m, :to_square_metres
  end
end
