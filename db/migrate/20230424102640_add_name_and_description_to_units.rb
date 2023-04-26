class AddNameAndDescriptionToUnits < ActiveRecord::Migration[7.0]
  def change
    add_column :units, :name, :string
    add_column :units, :description, :text
  end
end
