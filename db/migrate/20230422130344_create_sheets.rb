class CreateSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :sheets do |t|
      t.integer :thickness
      t.integer :width
      t.integer :length
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
