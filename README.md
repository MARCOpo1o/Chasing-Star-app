# Chasing Stars App

## Team Member

- Jingqian Cheng: Backend  
- Jian He: Frontend, UI/UX Design  
- Marco Qin: Machine learning/ Algorithm  
- Michael Jiang: Frontend  

## Summary

Chasing Stars is the one-stop solution for the perfect stargazing spots. This app is built for photographers, astronomy enthusiasts, and just anyone who ponders what is out there beyond us.  

Chasing stars provides users with the most up to date recommendations by applying light pollution API, weather API, and Geo API through a carefully researched and tested algorithm.  

With the newly added community features, users can also upload their own secret spots, share the photos taken there and even shooting parameters. When browsing through star gazing spots, these posts will pop up as a reference.  

## Core Featres
- **Interactive calendar** Enable users to browse and select date.
- **Location search** Search locations based on location name and selected date.
- **Dynamic map** Display locations with different markers based on each one's star visibility score, click the marker will popup location's info.
- **Star visibility calculation** Calculate a location's star visibility by applying light pollution API, weather API, and Geo API through a carefully researched and tested algorithm
- **Stargazing Recommendation** Choose a date and recommend the best stargazing locations of that day
- **Explore** Display hot posts
- **Stargazing Community** Allow users make posts with pictures to rate locations, and make comments to other users' posts.
- **Authentication System** Allow users to login and manage their contents, have admin users to manage the community and maintain locations.

## URL patterns and planned views

Route Name               Method  Url                                              Controller          Description
* root                   GET     /                                                main_pages#home     (default URL, shows the homepage with a interactive calendar)
* locations              GET     /location                                        locations#index     (lists all the locations we have)
* do_search_locations    GET     /locations/do_search                             locations#do_search (search locations based on location name and date)
* edit_location          GET     /locations/:id/edit                              locations#edit      (edit location, admin user only) 
* maps                   GET     /maps                                            maps#index          (shows the map page)
* recommend_maps         GET     /maps/recommend                                  maps#recommend      (recommend best stargazing locations of the selected date)
* login                  GET     /login                                           session#new         (show log in page)
* login                  POST    /login                                           session#create      (log in a user)
* logout                 DELETE  /logout                                          sessions#destroy    (logs out the current user)
* signup                 GET     /signup                                          user#new            (show sign up page)
* users                  POST    /users                                           users#create        (create a new user)
* users                  GET     /users                                           users#index         (displays all the users for admin users only)
* user                   GET     /users/:id                                       users#show          (display a specific user's profile and posts)
* edit_user              GET     /users/:id/edit                                  users#edit          (edit the users)
* new_user_post          GET     /users/:user_id/posts/new                        posts#new           (a page where users can make new post)
* user_posts             POST    /users/:user_id/posts                            posts#create        (create a new post)
* user_post              DELETE  /users/:user_id/posts/:id                        posts#destroy       (delete a post)
* new_user_post_comment  POST    /users/:user_id/posts/:post_id/comments          comments#create     (create new comment)                    
* edit_user_post_comment GET     /users/:user_id/posts/:post_id/comments/:id/edit comments#edit       (edit comment)                         
* user_post_comment      GET     /users/:user_id/posts/:post_id/comments/:id      comments#show       (show comment)    
* explore                GET     /explore                                         main_pages#explore  (a page where you can see the other users' posts)


## Trello link

[Trello](https://trello.com/b/LLSmtsFl/app-development)

## Prototype link
[Figma](https://www.figma.com/proto/KOc5UqZg2ftcQqWEvJlc2Z/Chasing-Stars?node-id=203%3A1393&page-id=203%3A1392&starting-point-node-id=203%3A1393)

## Heroku link
Deployment in progress

## Explaination of db Schema
### Tables:

```
  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.integer "user_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "light_pollutions", force: :cascade do |t|
    t.integer "pollution_index"
    t.date "date"
    t.json "coordinates"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_light_pollutions_on_date"
    t.index ["location_id"], name: "index_light_pollutions_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.json "image_json"
    t.float "average_rate"
    t.string "tag", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "bortleScale"
    t.integer "cloudCoverage"
    t.index ["location_name"], name: "index_locations_on_location_name"
  end

  create_table "photos", force: :cascade do |t|
    t.text "image_url"
    t.datetime "shooting_time"
    t.integer "user_id"
    t.integer "post_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "message"
    t.integer "rate"
    t.integer "user_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "selected_dates", force: :cascade do |t|
    t.string "title"
    t.string "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_locations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name"
    t.string "email"
    t.string "password"
    t.text "profile_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "weathers", force: :cascade do |t|
    t.string "weather_type"
    t.date "date"
    t.json "coordinates"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_weathers_on_date"
    t.index ["location_id"], name: "index_weathers_on_location_id"
  end
```


### Associations:

**One to One:**
Location <- Weather(location_id) 
Location <- Light_pollution(location_id) 
// each record of weather and light pollution is distinct since they are in different time  

**Many to One:**  
User <- Photo(user_id), Post(user_id), Comment(user_id)  

Location <- Photo(location_id), Post(location_id)  

**Many to Many:**  
User(location_id) <- UserLocation -> Location(user_id)

## Views

**Current Views**
* user (a form to create new user / demonstrate a user and his posts)
* session (login a user)
* map (contains an embedded map and location cards, can redirect to a location by clicking its marker)
* post (a form to create new post / show a post / delete a post)
* comment (a form to create new comment / show a comment / delete a comment)
* location (show a location)
* home (Home page, contains navbar, an interactive calendar, and a search bar)

**Planned Views**
* profile (show a user's saved locations, posts and comments)

## List of dependencies on APIs, gems, libraries

**API**
* Mapbox API
* Light Pollution API
* Weather API
* Location API (National Parks)
* Upslash API (seed images)

**Gems**
* Faker: This gem is a port of Perl's Data::Faker library that generates fake data.
* Bootstrap: The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
* Will_paginate: will_paginate is a pagination library that integrates with Ruby on Rails, Sinatra, Hanami::View, Merb, DataMapper and Sequel.
* Simple_calendar: A calendar for your Ruby on Rails app.
* Httparty: Fetch API data
* Dotenv-rails: Create environment variables
* Unsplash: Fetch Upslash API images

**Libraries**
* Boostrap
* Bcrypt
* Openssl
* URI
* Net/http
* MapBox

## Instruction on running tests
```
rails test
```


