class AddCloudCoverageToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :cloudCoverage, :integer
  end
end
