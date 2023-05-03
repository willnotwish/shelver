# frozen_string_literal: true

class PanelComponent < ViewComponent::Base
  attr_reader :panel

  def initialize(panel:, **)
    @panel = panel
  end
end
