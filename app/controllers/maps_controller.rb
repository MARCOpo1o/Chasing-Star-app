class MapsController < ApplicationController
  def index
    @locations = Location.all.paginate(page: params[:page])
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today
    @pins = Location.all
  end

  def recommend
    @locations = Location.all 
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today
    if (@date_diff <= 5)
      @locations.each do |location|
        cloudCover = @date_diff > 0 ? getWeatherForecast(location, (@date_diff - 1) * 8) : getWeatherCurrent(location)
        location.cloudCoverage = cloudCover
        location.save
      end
    end  
    @pins = Location.all 
    render :recommend
  end
end
