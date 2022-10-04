class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.json :coordinates
      t.float :average_rate
      t.string :tag, array: true, default: []
      t.integer :photo_id, array: true, default: []
      t.integer :post_id, array: true, default: []
      t.integer :weather_id
      t.integer :light_pollution_id

      t.timestamps
    end
  end
end
