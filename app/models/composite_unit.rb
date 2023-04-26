class CompositeUnit < ApplicationRecord
  belongs_to :unit
  belongs_to :composite

  enum orientation: { horizontal: 0, vertical: 1 }
end
