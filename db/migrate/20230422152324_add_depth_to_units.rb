class AddDepthToUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :units, :depth, :integer
  end
end
