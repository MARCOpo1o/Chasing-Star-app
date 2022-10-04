class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.text :profile_image_url
      t.integer :saved_locations, array: true, default: []
      t.integer :photo_id, array: true, default: []
      t.integer :post_id, array: true, default: []

      t.timestamps
    end
  end
end
