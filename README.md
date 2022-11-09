# Chasing Stars App

## Team7 Member

Jingqian Cheng: Backend  
Jian He: Frontend, UI/UX Design  
Marco Qin: Machine learning/ Algorithm  
Michael Jiang: Frontend  

## Summary

The product helps users find stargazing spots. By applying light pollution API, weather API, and Geo API, the Chasing Star app would be able to tell users the darkest spots near the user, it will recommend users the best location like national parks and wildlife reservations, and will suggest users the best time to visit based on the weather data. It will also calculate the angle the user can turn their heads to/ point their telescope at. Users can also upload their own secret spots, and share their photos or even shooting parameters at the place. The app also has a stargazing community, where users could share their photos and shooting experiences.

## URL patterns and planned views

Route Name      Method  Url                        Controller          Description
* root          GET     /                          main_pages#home     (default URL, shows the homepage with a interactive calendar)
* locations     GET     /location                  locations#index     (lists all the locations we have)
* maps          GET     /maps                      maps#index          (shows the map page)
* login         GET     /login                     session#new         (show log in page)
* login         POST    /login                     session#create      (log in a user)
* logout        DELETE  /logout                    sessions#destroy    (logs out the current user)
* signup        GET     /signup                    user#new            (show sign up page)
* users         POST    /users                     users#create        (create a new user)
* users         GET     /users                     users#index         (displays all the users for admin users only)
* user          GET     /users/:id                 users#show          (display a specific user's profile and posts)
* edit_user     GET     /users/:id/edit            users#edit          (edit the users)
* new_user_post GET     /users/:user_id/posts/new  posts#new           (a page where users can make new post)
* user_posts    POST    /users/:user_id/posts      posts#create        (create a new post)
* user_post     DELETE  /users/:user_id/posts/:id  posts#destroy       (delete a post)
* explore       GET     /explore                   main_pages#explore  (will implement in the future, a page where you can see the other users' posts)


## Trello link

[Trello](https://trello.com/b/LLSmtsFl/app-development)

## Prototype link
[Figma](https://www.figma.com/proto/KOc5UqZg2ftcQqWEvJlc2Z/Chasing-Stars?node-id=203%3A1393&page-id=203%3A1392&starting-point-node-id=203%3A1393)

## Heroku link
[Heroku](https://chasing-star-app.herokuapp.com)

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
    t.datetime "time"
    t.json "coordinates"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.json "coordinates"
    t.float "average_rate"
    t.string "tag", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "time"
    t.json "coordinates"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
* map (contains an embedded map and location cards, can redirect to locations by clicking them)
* post (a form to create new post / show a post / delete a post)
* location (show all locations)
* home (Home page, contains navbar, an interactive calendar, and a search bar)

**Planned Views**
* profile (show a user's saved locations, posts and comments)
* comment (show comments of a post)

## List of dependencies on APIs, gems, libraries

**API**
* Map API
* Light Pollution API
* Weather API
* Location API

**Gems**
* Faker: This gem is a port of Perl's Data::Faker library that generates fake data.
* Bootstrap: The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
* Will_paginate: will_paginate is a pagination library that integrates with Ruby on Rails, Sinatra, Hanami::View, Merb, DataMapper and Sequel.
* Simple_calendar: A calendar for your Ruby on Rails app.

**Libraries**
* Boostrap
* Bcrypt
* Openssl
* URI
* Net/http

## Instruction on running tests
```
rails test
```


