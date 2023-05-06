# frozen_string_literal: true

# Adds geometry helpers
module UnitGeometry
  extend ActiveSupport::Concern

  included do
    helper_method :unit_geometry
  end
end
