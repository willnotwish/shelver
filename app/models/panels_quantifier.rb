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
  class Size
    attr_reader :x, :y

    def initialize(width, length)
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
    # Returns a hash like this
    # {
    #   [300, 200] => 4,  # 4 off 300 x 200
    #   [1220, 300] => 2
    # }
    def quantify(panels)
      hash = {}
      panels.each do |panel|
        size = Size.new(panel.x, panel.y)
        hash[size] ||= 0
        hash[size] += 1
      end
      hash
    end
  end
end
