class LocationsController < ApplicationController
  before_action :set_location, only: %i[ show edit update destroy ]
  before_action :admin_user,     only: :edit

  # GET /locations or /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1 or /locations/1.json
  def show
    @location = Location.find(params[:id])
    @average_rate = @location.posts.length.positive? ? @location.posts.average(:rate).round(1) : 0
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @cloudCover = @date_diff > 0 ? getWeatherForecast((@date_diff - 1) * 8) : getWeatherCurrent # a 0 param means 06:00 tomorrow, delta 1 means 3 hour's change, e.g. 8 means 06:00 the day after tomorrow
    # @weatherInfo = @date_diff > 0 ? getWeatherForecastInfo((@date_diff - 1) * 8) : Time.now
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today
    @bortleScale = getLightPollution
    @user = current_user
    @posts = @location.posts.paginate(page: params[:page])
    
    @score = starVisibility(@cloudCover, @bortleScale)
    session.delete(:return_to)
    session[:return_to] = request.original_url
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    # @location.image.attach(params[:location][:image])
  end

  # POST /locations or /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to location_url(@location), notice: "Location was successfully created." }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1 or /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to location_url(@location), notice: "Location was successfully updated." }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1 or /locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def do_search
    @locations = Location.where("location_name ILIKE ?", "%#{params[:location_name]}%")
    @date = params[:date] == nil ? Date.today : Date.parse(params[:date])
    @date_diff = (@date - Date.today).to_i >= 0 ? (@date - Date.today).to_i : 0
    @show_date = @date_diff > 0 ? Date.today + @date_diff : Date.today
    render :index
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def location_params
      params.require(:location).permit(:location_name, :average_rate, :image)
    end

    def admin_user
      redirect_to root_url, status: :see_other unless current_user && current_user.admin?
    end

    def getWeatherCurrent
      @location = Location.find(params[:id])
      api_key1 = ENV['WEATHER_API_KEY']
      log = @location.longitude #longitude
      lat = @location.latitude #latitude
      # hour_ahead = 0 #how many days ahead
      cloudCover = nil 

      currentWeather = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{log}&appid=#{api_key1}&units=imperial")
      #turn response into json
      currentWeather = JSON.parse(currentWeather.body)
      # puts currentWeather
      cloudCover = currentWeather["clouds"]["all"] #0-100 skil 0 is clear and 100 is overcast
      cloudCover = cloudCover.to_i
      
      cloudCover
    end

    def getWeatherForecastInfo(hour_ahead)
      @location = Location.find(params[:id])
      api_key1 = ENV['WEATHER_API_KEY']
      log = @location.longitude #longitude
      lat = @location.latitude #latitude
      # hour_ahead = 0 #how many days ahead
      cloudCover = nil 

      forecast = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{log}&appid=#{api_key1}")
      forecast = JSON.parse(forecast.body)

      info = forecast["list"][hour_ahead].nil? ? "No Data" : forecast["list"][hour_ahead]["dt_txt"]

      info
    end

    def getWeatherForecast(hour_ahead)
      @location = Location.find(params[:id])
      api_key1 = ENV['WEATHER_API_KEY']
      log = @location.longitude #longitude
      lat = @location.latitude #latitude
      # hour_ahead = 0 #how many days ahead
      cloudCover = nil 

      forecast = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{log}&appid=#{api_key1}")
      forecast = JSON.parse(forecast.body) 
      cloudCover = forecast["list"][hour_ahead].nil? ? "No Data" : forecast["list"][hour_ahead]["clouds"]["all"]
      # puts forecast["list"][hour_ahead]["dt_txt"]
      cloudCover = cloudCover.to_i if cloudCover != "No Data"

      cloudCover
    end

    def getLightPollution
      @location = Location.find(params[:id])
      api_key2 = ENV['LIGHT_POLLUTION_API_KEY']
      log = @location.longitude #longitude
      lat = @location.latitude #latitude

      def cleanLPdata(light_pollution)
        #remove the number after the comma
        return light_pollution.first(10).to_f
      end
  
      light_pollution = HTTParty.get("https://www.lightpollutionmap.info/QueryRaster/?ql=wa_2015&qt=point&qd=#{log},#{lat}&key=#{api_key2}")
      artificial_brightness = cleanLPdata(light_pollution)
      sqm = Math.log10((artificial_brightness+0.171168465)/108000000)/(-0.4)
  
      def bortleScale(sqm)
        light_pollution = sqm.to_f
        if light_pollution > 21.99
          return 1
        elsif light_pollution > 21.89
          return 2
        elsif light_pollution > 21.69
          return 3
        elsif light_pollution > 20.49
          return 4
        elsif light_pollution > 19.5
          return 5
        elsif light_pollution > 18.94
          return 6
        elsif light_pollution > 18.38
          return 7
        else
          return 8
        end
      end

      bortleScale(sqm)
    end

    def starVisibility(cloudCover, bortleScale)
      if cloudCover == "No Data"
        return "No Data"
      elsif cloudCover > 50 or bortleScale > 6
        return 0
      else  
        (100-cloudCover)-(bortleScale-1)*10
      end
    end  
end
 