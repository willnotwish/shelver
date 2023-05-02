# frozen_string_literal: true

# Panel-related view helpers
module PanelsHelper
  def quantify_panels(panels:, **)
    PanelsQuantifier.quantify(panels)
  end
end
