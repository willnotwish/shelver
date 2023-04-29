# frozen_string_literal: true

# A simple rectangular storage unit: a box without front and back and a variable number of full-width shelves
class Unit < ApplicationRecord
  enum kind: { plain: 0, corner: 1 }

  belongs_to :sheet

  has_many :composite_units
  has_many :composites, through: :composite_units

  validates :name, :code, :kind, :width, :height, :depth, presence: true
  validates :width, :height, :depth, :shelf_count, numericality: { only_integer: true, greater_than: 0 }
  validates :offset_top, :offset_bottom, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
