class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :message
      t.integer :rate
      t.integer :creator_id
      t.integer :location_id
      t.integer :comment_id, array: true, default: []
      t.integer :photo_id, array: true, default: []

      t.timestamps
    end
  end
end
