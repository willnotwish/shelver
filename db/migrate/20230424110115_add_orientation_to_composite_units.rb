class AddOrientationToCompositeUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :composite_units, :orientation, :integer, default: 0
  end
end
