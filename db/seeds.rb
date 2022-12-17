# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# User.create(user_name: "Jingqian", email: "jingqiancheng@brandeis.edu", password: "123", profile_image_url: "fakeurl.com")
# Location.create(location_name: "Waltham", average_rate: 4.5, tag:["small town"])
# Post.create(message: "First message", rate:5, creator_id:1, location_id: 1)
# Photo.create(image_url: "fakeurl.com", uploader_id:1, post_id: 1, location_id:1)
# Comment.create(message: "First comment", creator_id:1, post_id:1)
# Weather.create(weather_type: "Sunny", location_id:1)
# LightPollution.create(pollution_index:50, location_id:1)

require 'faker'
require 'json'

def configure
    Unsplash.configure do |config|
        config.application_access_key = ENV['UNSPLASH_API_KEY']
        config.application_secret = ENV['UNSPLASH_SECRET_API_KEY']
        # config.application_redirect_uri = ENV['UNSPLASH_REDICT_URI']
        config.utm_source = "Chasing stars"
    end
end

def getStarPic
    configure
    image = Unsplash::Photo.random(count: 1, query: 'stars in the sky')
    puts "star pic: #{image}"
    return image.nil? ? nil : image
end

def getLightPollution(log, lat)

    api_key2 = ENV['LIGHT_POLLUTION_API_KEY']

    def cleanLPdata(light_pollution)
      #remove the number after the comma
      return light_pollution.first(10).to_f
    end

    light_pollution = HTTParty.get("https://www.lightpollutionmap.info/QueryRaster/?ql=wa_2015&qt=point&qd=#{log},#{lat}&key=#{api_key2}")
    puts "light_pollution: #{light_pollution}"
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

if ENV["users"]
  #test user
  User.create(user_name: Faker::Name.name, email: "aaa@aaa.com", password: "aaaaaa")

  # Create a main sample user.
  User.create!(user_name:  "Example User",
      email: "example@railstutorial.org",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true)

  # Generate a bunch of additional users.
  100.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(user_name:  name,
        email: email,
        password:              password,
        password_confirmation: password)
  end
  # Generate posts for a subset of users.
end

if ENV["locations"]
  #locations
  national_parks = File.read(File.join(Rails.root, 'app', 'assets', 'dataset', 'national_parks.json'))
  national_parks_hash = JSON.parse(national_parks)
  i = 1

  national_parks_hash.each do |park|
      bortleScale = getLightPollution(park['longitude'], park['latitude'])

      if i < 50 # unsplash api only allows 50 requests per hour
          Location.create(location_name: park['park_name'], latitude: park['latitude'], longitude: park['longitude'], image_json: getStarPic, bortleScale: bortleScale)
          i = i+1
      else 
          Location.create(location_name: park['park_name'], latitude: park['latitude'], longitude: park['longitude'], bortleScale: bortleScale) 
      end
  end
end

if ENV["posts"]
  users = User.order(:created_at).take(10)
  5.times do
    message = Faker::Lorem.sentence(word_count: 10)
    users.each { |user| user.posts.create!(message: message, rate: Faker::Number.between(from: 1, to: 5), location_id: Faker::Number.between(from: 1, to: 10), image_json: getStarPic) }
  end
  
  5.times do
    comment = Faker::Lorem.sentence(word_count: 10) 
    users.each { |user| user.comments.create!(message: comment, post_id: Faker::Number.between(from: 1, to: 10)) }   
  end
end


