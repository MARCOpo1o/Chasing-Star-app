class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :image_url
      t.string :uploader
      t.string :shooting_time
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
