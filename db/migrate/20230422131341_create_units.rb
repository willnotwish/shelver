class CreateUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.references :sheet, null: false, foreign_key: true
      t.string :code, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :offset_top, null: false, default: 0
      t.integer :offset_bottom, null: false, default: 0
      t.integer :shelf_count, null: false, default: 1

      t.timestamps
    end
  end
end
