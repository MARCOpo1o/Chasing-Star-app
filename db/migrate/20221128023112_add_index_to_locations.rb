class AddIndexToLocations < ActiveRecord::Migration[7.0]
  def change
    add_index :locations, :location_name
    add_index :weathers, :location_id
    add_index :weathers, :date
    add_index :light_pollutions, :location_id
    add_index :light_pollutions, :date
  end
end
