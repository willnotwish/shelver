# frozen_string_literal: true

module Units
  # Used in text representations
  class OverviewComponent < ViewComponent::Base
    include LinkTo

    attr_reader :unit, :name

    def initialize(unit:, material: true, name: nil)
      super
      @unit = unit
      @show_material = material
      @name = if name != false
                name || unit.name
              else
                false
              end
    end

    def show_material?
      @show_material
    end

    def show_name?
      @name != false
    end

    alias unit_name name
    
    delegate :kind, to: :unit, prefix: true
    alias unit_type unit_kind
  end
end
