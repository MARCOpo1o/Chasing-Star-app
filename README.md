# Chasing Stars App

## Summary

The product helps users find stargazing spots. By applying light pollution API, weather API, and Geo API, the Chasing Star app would be able to tell users the darkest spots near the user, it will recommend users the best location like national parks and wildlife reservations, and will suggest users the best time to visit based on the weather data. It will also calculate the angle the user can turn their heads to/ point their telescope at. Users can also upload their own secret spots, and share their photos or even shooting parameters at the place. The app also has a stargazing community, where users could share their photos and shooting experiences.

## Trello link

[![Trello](https://img.shields.io/badge/Trello-%23026AA7.svg?style=for-the-badge&logo=Trello&logoColor=white)][1]

## Team Member Interests

Jingqian Cheng: Backend
Jian He: Frontend, UI/UX Design
Marco Qin: Machine learning/ Algorithm
Michael Jiang: Frontend

## Explaination of Schema


### Tables:

**Table 1:** User users {user_name: string, email: string, password: string, profile_image_url: text, saved_locations: integer[], photo_id: integer[], post_id: integer[]}  

**Table 2:** Photo photos {image_url: text, shooting_time: datetime, uploader_id: integer, post_id: integer, location_id: integer}  

**Table 3:** Location locations {location_name: string, coordinates: json, average_rate: float, tag: string[], photo_id: integer[], post_id: integer[], weather_id: integer, light_pollution_id: integer}  

**Table 4:** Post posts {message: text, rate: integer, creator_id: integer, location_id: integer, comment_id: integer[], photo_id: integer[]}  

**Table 5:** Comment comments {message: text, creator_id: integer, post_id: integer}  

**Table 6:** Weather weathers {weather_type: string, time: datetime, coordinates: json, location_id: integer}  

**Table 7:** Light_pollution light_pollutions {pollution_index: integer, time: datetime, coordinates: json, location_id: integer}


### Associations:

**One to One:**
Location -> Weather(location_id), Light_pollution(location_id)  

Weather -> Location(weather_id)  

Light_pollution -> Location(light_pollution_id) // each record of weather and light pollution is distinct since they are in different time  

**One to Many:**  
User -> Photo(uploader_id), Post(creator_id), Comment(creator_id)  

Location -> Photo(location_id), Post(location_id)  

**Many to One:**  

Photo -> User(photo_id), Post(photo_id)  

Post -> User(post_id), Location(post_id)  

Comment -> Post(comment_id)  

Location -> User(saved_locations)  

