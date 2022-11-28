class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :weathers, :time, :date
    rename_column :light_pollutions, :time, :date
  end
end
