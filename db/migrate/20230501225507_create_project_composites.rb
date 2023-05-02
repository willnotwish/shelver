# frozen_string_literal: true

# Join table migration
class CreateProjectComposites < ActiveRecord::Migration[7.0]
  def change
    create_table :project_composites do |t|
      t.references :project, null: false, foreign_key: true
      t.references :composite, null: false, foreign_key: true
      t.integer :position, default: 100, null: false

      t.timestamps
    end
    add_index :project_composites, :position
  end
end
