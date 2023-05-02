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
  class Key
    attr_reader :x, :y

    def initialize(width:, length:)
      @x = width
      @y = length
    end

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
    # Returns a hash of hashes. The outer hash is keyed on sheet_id (material).
    # The inner is keyed on 2D dimensions (width & length - interchangable).
    def quantify(panels)
      by_sheet_id = {}
      panels.each do |panel|
        sheet_id = panel.sheet_id
        by_sheet_id[sheet_id] ||= {}
        hash = by_sheet_id[sheet_id]

        size = Key.new(width: panel.x, length: panel.y)
        hash[size] ||= 0
        hash[size] += 1
      end
      by_sheet_id
    end
  end
end
