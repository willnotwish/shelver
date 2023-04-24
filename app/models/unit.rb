class Unit < ApplicationRecord
  belongs_to :sheet

  def uniform_shelf_spacing
    (height - ((shelf_count + 1) * sheet.thickness + offset_top + offset_bottom)) / shelf_count
  end

  def shelf_width
    width - 2 * sheet.thickness
  end

  def shelf_area
    shelf_count * shelf_width * depth
  end

  def shelf_depth
    depth
  end
end
