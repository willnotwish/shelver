# frozen_string_literal: true

# A simple rectangular storage unit: a box without front and back and a variable number of full-width shelves
class Unit < ApplicationRecord
  enum kind: { plain: 0, corner: 1 }

  belongs_to :sheet

  has_many :composite_units
  has_many :composites, through: :composite_units

  validates :code, :kind, :width, :height, :depth, presence: true
end
