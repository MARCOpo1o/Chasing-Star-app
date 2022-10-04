class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.text :image_url
      t.datetime :shooting_time
      t.integer :uploader_id
      t.integer :post_id
      t.integer :location_id

      t.timestamps
    end
  end
end
