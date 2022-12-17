module LocationsHelper
    def getWeatherCurrent(location)
        @location = location
        api_key1 = ENV['WEATHER_API_KEY']
        log = @location.longitude #longitude
        lat = @location.latitude #latitude
        cloudCover = nil 
  
        currentWeather = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{log}&appid=#{api_key1}&units=imperial")
        #turn response into json
        currentWeather = JSON.parse(currentWeather.body)
        # puts currentWeather
        cloudCover = currentWeather["clouds"]["all"] #0-100 skil 0 is clear and 100 is overcast
        cloudCover = cloudCover.to_i
        
        cloudCover
    end
  
    def getWeatherForecastInfo(location, hour_ahead)
        @location = location
        api_key1 = ENV['WEATHER_API_KEY']
        log = @location.longitude #longitude
        lat = @location.latitude #latitude
        cloudCover = nil 
  
        forecast = HTTParty.get("https://api.openweathermap.org/data/2.5/forecast?lat=#{lat}&lon=#{log}&appid=#{api_key1}")
        forecast = JSON.parse(forecast.body)
  
        info = forecast["list"][hour_ahead].nil? ? "No Data" : forecast["list"][hour_ahead]["dt_txt"]
  
        info
    end
  
    def getWeatherForecast(location, hour_ahead)
        @location = location
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

    def bortleScale(light_pollution)
      light_pollution = Math.log10((artificial_brightness+0.171168465)/108000000)/(-0.4)
      light_pollution = light_pollution.to_f
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
  
    def getLightPollution(location)
        @location = location 
        api_key2 = ENV['LIGHT_POLLUTION_API_KEY']
        log = @location.longitude #longitude
        lat = @location.latitude #latitude
  
        def cleanLPdata(light_pollution)
          #remove the number after the comma
          return light_pollution.first(10).to_f
        end
    
        light_pollution = HTTParty.get("https://www.lightpollutionmap.info/QueryRaster/?ql=wa_2015&qt=point&qd=#{log},#{lat}&key=#{api_key2}")
        artificial_brightness = cleanLPdata(light_pollution)
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
