# frozen_string_literal: true

class UnitPreviewComponent < ViewComponent::Base
  attr_reader :unit

  def initialize(unit:)
    @unit = unit
  end

  delegate :shelf_count, to: :unit

  def dynamic_unit_style
    "width: #{unit.width}px"
  end

  def dynamic_style(kind: :shelf)
    height = 
      if kind == :shelf
        shelf_void_height
      elsif kind == :top_void
        unit.offset_top
      elsif kind == :bottom_void
        unit.offset_bottom
      end  

    "height: #{height}px"
  end

  def shelf_void_height
    unit.uniform_shelf_spacing - unit.sheet.thickness
  end
end
