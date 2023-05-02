# frozen_string_literal: true

# A project is the top-level container
class Project < ApplicationRecord
  has_many :project_composites
  has_many :composites, through: :project_composites
  has_many :units, through: :composites

  validates :name, presence: true
end
