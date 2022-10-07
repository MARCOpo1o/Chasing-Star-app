class ChangeColumnNameInWeatherTable < ActiveRecord::Migration[7.0]
  def change
    rename_column :weathers, :type, :weather_type 
  end
end
