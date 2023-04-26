# frozen_string_literal: true

module Units
  class ShelvesComponent < BaseComponent
    delegate :shelf_count, :uniform_shelf_spacing, to: :unit
  end
end
