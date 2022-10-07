class CreateLightPollutions < ActiveRecord::Migration[7.0]
  def change
    create_table :light_pollutions do |t|
      t.integer :pollution_index
      t.datetime :time
      t.json :coordinates
      t.integer :location_id

      t.timestamps
    end
  end
end
