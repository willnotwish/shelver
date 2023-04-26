class AddPositionToCompositeUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :composite_units, :position, :integer, default: 100, nil: false
  end
end
