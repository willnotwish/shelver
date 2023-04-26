class CreateCompositeUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :composite_units do |t|
      t.references :unit, null: false, foreign_key: true
      t.references :composite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
