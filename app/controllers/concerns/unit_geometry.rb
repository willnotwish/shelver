# frozen_string_literal: true

# Adds geometry helpers
module UnitGeometry
  extend ActiveSupport::Concern

  included do
    helper_method :unit_geometry
  end

  def unit_geometry(unit:, kind: nil)
    kind ||= unit.kind
    klass_name = "Geometry::#{kind.classify}Unit"
    klass_name.constantize.new(unit:)
  end
end
