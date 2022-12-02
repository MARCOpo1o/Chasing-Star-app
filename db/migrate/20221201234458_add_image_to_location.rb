class AddImageToLocation < ActiveRecord::Migration[7.0]
  def change
    rename_column :locations, :coordinates, :image_json
  end
end
