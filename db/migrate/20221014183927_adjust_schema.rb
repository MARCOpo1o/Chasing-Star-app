class AdjustSchema < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :creator_id, :user_id
    remove_column :locations, :photo_id
    remove_column :locations, :post_id
    remove_column :locations, :weather_id
    remove_column :locations, :light_pollution_id
    rename_column :photos, :uploader_id, :user_id
    rename_column :posts, :creator_id, :user_id
    remove_column :posts, :comment_id
    remove_column :users, :saved_locations
    remove_column :users, :photo_id
    remove_column :users, :post_id
  end
end
