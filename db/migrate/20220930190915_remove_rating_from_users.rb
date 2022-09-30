class RemoveRatingFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :rating, :integer
  end
end
