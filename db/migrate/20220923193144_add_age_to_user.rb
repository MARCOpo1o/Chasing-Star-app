class AddAgeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :age, :integer 
  end
end
