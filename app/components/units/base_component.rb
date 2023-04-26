# frozen_string_literal: true

module Units
  class BaseComponent < ViewComponent::Base
    attr_reader :unit

    def initialize(unit:, **)
      @unit = unit
    end
  end
end
