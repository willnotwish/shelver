# frozen_string_literal: true

module Units
  class SheetMaterialComponent < BaseComponent
    include LinkTo
    
    delegate :shelf_width, :shelf_depth, :shelf_count, :sheet, to: :unit
    delegate :height, :depth, to: :unit, prefix: true
    
    def minimum_number_of_sheets_needed
      sheet_usage.round(2)
    end

    def side_area
      2 * unit_height * unit_depth
    end
  
    def shelf_area
      shelf_count * shelf_width * shelf_depth
    end

    def total_area
      shelf_area + side_area
    end
  
    alias material_area total_area
  
    def sheet_usage
      sheet_area = sheet.width * sheet.length
      total_area.to_f / sheet_area
    end
  end
end
