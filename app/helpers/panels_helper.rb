# frozen_string_literal: true

# Panel-related view helpers
module PanelsHelper
  def quantify_panels(panels:, scale: nil, **)
    PanelsQuantifier.quantify(panels, scale:)
  end
end
