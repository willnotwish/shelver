class CreatePanels < ActiveRecord::Migration[7.0]
  def change
    create_table :panels do |t|
      t.integer :x
      t.integer :y
      t.references :sheet, null: false, foreign_key: true
      t.string :label
      t.text :description

      t.timestamps
    end
  end
end
