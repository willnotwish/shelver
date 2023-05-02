# frozen_string_literal: true

module Geometry
  module HasUniformShelfSpacing
    def uniform_shelf_spacing
      (height - offset_top - offset_bottom - thickness_of_top) / shelf_count
    end
  end
end