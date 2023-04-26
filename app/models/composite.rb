# frozen_string_literal: true

# A composite is composed of units
class Composite < ApplicationRecord
  has_many :composite_units, -> { order(position: :asc) }
  has_many :units, through: :composite_units

  has_many :horizontal_composite_units, -> { horizontal.order(position: :asc) }, class_name: 'CompositeUnit'
  has_many :horizontal_units, through: :horizontal_composite_units, source: :unit

  has_many :vertical_composite_units, -> { vertical.order(position: :asc) }, class_name: 'CompositeUnit'
  has_many :vertical_units, through: :vertical_composite_units, source: :unit

  def max_width
    [
      horizontal_units.map(&:width).reduce(0) { |total, width| total + width },
      vertical_units.map(&:width).max
    ].compact.max
  end

  def max_height
    [
      vertical_units.map(&:height).reduce(0) { |total, value| total + value },
      horizontal_units.map(&:height).max
    ].compact.max
  end

  def max_depth
    [
      vertical_units.map(&:depth).max,
      horizontal_units.map(&:depth).max
    ].compact.max
  end
end
