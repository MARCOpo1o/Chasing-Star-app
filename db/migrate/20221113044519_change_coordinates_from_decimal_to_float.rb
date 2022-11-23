class ChangeCoordinatesFromDecimalToFloat < ActiveRecord::Migration[7.0]
  def change
    change_column :locations, :latitude, :float
    change_column :locations, :longitude, :float
  end
end
