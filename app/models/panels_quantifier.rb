# frozen_string_literal: true

# Quantifies panels
class PanelsQuantifier
  attr_reader :panels

  def initialize(panels:)
    @panels = panels
  end

  def quantified_panels
    @quantified_panels ||= self.class.quantify(panels)
  end

  # Used as a hash key
  class PanelAsKey
    attr_reader :panel

    def initialize(panel:, **)
      @panel = panel
    end

    delegate :x, :y, to: :panel

    def to_a
      [x, y]
    end

    def eql?(other)
      (x == other.x && y == other.y) || (x == other.y && y == other.x)
    end

    def hash
      to_a.hash
    end

    def to_s
      [to_a.max, to_a.min].join(' x ')
    end
  end

  class << self
    # Returns a hash of hashes. The outer hash is keyed on sheet (material).
    # The inner is keyed on 2D dimensions (width & length - interchangable).
    def quantify(panels)
      by_sheet = {}
      panels.each do |panel|
        sheet = panel.sheet
        by_sheet[sheet] ||= {}
        hash = by_sheet[sheet]

        key = PanelAsKey.new(panel:)
        hash[key] ||= 0
        hash[key] += 1
      end
      by_sheet
    end
  end
end
