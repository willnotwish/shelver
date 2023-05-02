# frozen_string_literal: true

# A simple rectangular storage unit: a box without front and back and a variable number of full-width shelves
class Unit < ApplicationRecord
  enum kind: { plain: 0, corner: 1 }

  belongs_to :sheet

  has_many :composite_units
  has_many :composites, through: :composite_units

  # Dimensions
  # t.integer "width", null: false
  # t.integer "height", null: false
  # t.integer "offset_top", default: 0, null: false
  # t.integer "offset_bottom", default: 0, null: false
  # t.integer "depth"

  # Shelves
  # t.integer "shelf_count", default: 1, null: false

  validates :name, :code, :kind, :width, :height, :depth, presence: true
  validates :width, :height, :depth, :shelf_count, numericality: { only_integer: true, greater_than: 0 }
  validates :offset_top, :offset_bottom, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
