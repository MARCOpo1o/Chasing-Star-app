class CreateUserLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :user_locations do |t|
      t.integer :user_id
      t.integer :location_id
      t.timestamps
    end
  end
end
