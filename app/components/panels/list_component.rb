# frozen_string_literal: true

class Panels::ListComponent < ViewComponent::Base
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
