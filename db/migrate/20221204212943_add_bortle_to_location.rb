class AddBortleToLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :bortleScale, :integer
  end
end
