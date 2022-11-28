class DatetimeTodate < ActiveRecord::Migration[7.0]
  def change
    change_column :weathers, :date, :date
    change_column :light_pollutions, :date, :date
  end
end
