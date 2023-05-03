# frozen_string_literal: true

module Panels
  class ListComponent < ViewComponent::Base
    attr_reader :panels, :name

    def initialize(panels:, name:, show_details: true, show_quantified: true)
      @panels = panels
      @name = name
      @show_details = show_details
      @show_quantified = show_quantified
    end

    def show_details?
      @show_details
    end

    def show_quantified?
      @show_quantified
    end
  end
end
