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
require_relative 'seed_more.rb'

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
    return image
end


#locations
national_parks = File.read(File.join(Rails.root, 'app', 'assets', 'dataset', 'national_parks.json'))
national_parks_hash = JSON.parse(national_parks)
i = 1;
national_parks_hash.each do |park|
    if i < 50
        Location.create(location_name: park['park_name'], latitude: park['latitude'], longitude: park['longitude'], image_json: getStarPic)
        i = i+1
    else 
        Location.create(location_name: park['park_name'], latitude: park['latitude'], longitude: park['longitude']) 
    end
end

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
users = User.order(:created_at).take(10)
10.times do
  message = Faker::Lorem.sentence(word_count: 10)
  users.each { |user| user.posts.create!(message: message, rate: Faker::Number.between(from: 1, to: 5), location_id: Faker::Number.between(from: 1, to: 10)) }
end

10.times do
  comment = Faker::Lorem.sentence(word_count: 10) 
  users.each { |user| user.comments.create!(message: comment, post_id: Faker::Number.between(from: 1, to: 100)) }   
end


