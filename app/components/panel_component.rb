# frozen_string_literal: true

# Displays panels
class PanelComponent < ViewComponent::Base
  include Geometry::Scalable

  attr_reader :panel, :quantity

  def initialize(panel:, show_label: true, quantity: nil, **)
    super
    @panel = panel
    @show_label = show_label
    @quantity = quantity
  end

  delegate :x, :y, :label, to: :panel, prefix: true

  # Consider adding prefix to options
  delegate_dimension :x, to: :panel, as: :scaled_x
  delegate_dimension :y, to: :panel, as: :scaled_y

  def show_label?
    @show_label
  end

  def show_quantity?
    quantity.present?
  end

  alias panel_quantity quantity
end
