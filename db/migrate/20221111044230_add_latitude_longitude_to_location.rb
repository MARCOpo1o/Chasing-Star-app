class AddLatitudeLongitudeToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :latitude, :decimal
    add_column :locations, :longitude, :decimal
  end
end
