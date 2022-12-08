class AddImageToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :image_json, :json
  end
end
