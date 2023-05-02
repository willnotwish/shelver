module ApplicationHelper
  def unit_geometry(unit:, kind: nil)
    kind ||= unit.kind
    klass_name = "Geometry::#{kind.classify}Unit"
    klass_name.constantize.new(unit:)
  end
end
