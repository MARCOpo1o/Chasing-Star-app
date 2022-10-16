class AdjustSchema2 < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :photo_id
  end
end
