# frozen_string_literal: true

module Units
  class OverviewComponent < BaseComponent
    include LinkTo

    def initialize(unit:, material: true)
      @show_material = material
      super
    end

    def show_material?
      @show_material
    end
  end
end
