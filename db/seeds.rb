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

#test user
User.create(user_name: Faker::Name.name, email: "aaa@aaa.com", password: "aaaaaa")

#users
(1..10).each do 
    User.create(user_name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end

#locations
(1..10).each do 
    Location.create(location_name: Faker::Address.city, average_rate: Faker::Number.decimal(l_digits: 1))
end

#posts
(1..10).each do 
    Post.create(message: Faker::SlackEmoji.nature, rate: Faker::Number.between(from: 1, to: 10), user_id: Faker::Number.number(digits: 1), location_id: Faker::Number.number(digits: 1))
end

#photos
(1..10).each do 
    Photo.create(image_url: Faker::Internet.url(host: 'example.com'), user_id: Faker::Number.number(digits: 1), post_id: Faker::Number.number(digits: 1), location_id:Faker::Number.number(digits: 1))
end

#comments
(1..10).each do 
    Comment.create(message: Faker::SlackEmoji.nature, user_id: Faker::Number.number(digits: 1), post_id: Faker::Number.number(digits: 1))
end

#weathers
(1..10).each do 
    Weather.create(weather_type: "Sunny", location_id: Faker::Number.number(digits: 1))
end

#LightPollution
(1..10).each do 
    LightPollution.create(pollution_index: Faker::Number.number(digits: 3), location_id: Faker::Number.number(digits: 1))
end

#user_locations
(1..10).each do 
    UserLocation.create(user_id: Faker::Number.number(digits: 1), location_id: Faker::Number.number(digits: 1))
end

# Create a main sample user.
User.create!(user_name:  "Example User",
    email: "example@railstutorial.org",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true)

# Generate a bunch of additional users.
50.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(user_name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end
# Generate posts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  message = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.posts.create!(message: message, location_id: 1) }
end

