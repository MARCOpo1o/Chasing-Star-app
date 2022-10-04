# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(user_name: "Jingqian", email: "jingqiancheng@brandeis.edu", password: "123", profile_image_url: "fakeurl.com")
Location.create(location_name: "Waltham", average_rate: 4.5, tag:["small town"])
Post.create(message: "First message", rate:5, creator_id:1, location_id: 1)
Photo.create(image_url: "fakeurl.com", uploader_id:1, post_id: 1, location_id:1)
Comment.create(message: "First comment", creator_id:1, post_id:1)
Weather.create(weather_type: "Sunny", location_id:1)
LightPollution.create(pollution_index:50, location_id:1)
