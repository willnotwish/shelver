class CreateUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :units do |t|
      t.references :sheet, null: false, foreign_key: true
      t.string :code
      t.integer :width
      t.integer :height
      t.integer :offset_top
      t.integer :offset_bottom
      t.integer :shelf_count

      t.timestamps
    end
  end
end
