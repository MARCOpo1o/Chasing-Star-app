class CreateWeathers < ActiveRecord::Migration[7.0]
  def change
    create_table :weathers do |t|
      t.string :type
      t.datetime :time
      t.json :coordinates
      t.integer :location_id

      t.timestamps
    end
  end
end
