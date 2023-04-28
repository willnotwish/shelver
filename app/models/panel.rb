class Panel < ApplicationRecord
  # t.integer "x"
  # t.integer "y"
  # t.string "label"
  # t.text "description"

  belongs_to :sheet

  validates :x, :y, :label, presence: true
end
