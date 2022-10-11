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

We will have user schema{Username, Userid} and a photo schema {photoid, userid, photo location, shootin time}, geodata {location, light pollution, weather}

春眠不觉晓
处处闻啼鸟
夜来风雨声
花落知多少

Table 1: User users {user_name:string email:string password:string}
Table 2: Photo photos
Table 3: Location locations {location_name:string coordinates:array}
Table 4: Weather
Table 5: Light_pollution light_pollutions

- Table 1: User users
- Table 2: Photo photos
- Table 3: Location locations
- Table 4: Weather
- Table 5: Light_pollution light_pollutions

## First model

```
$ rails generate scaffold User user_name:string email:string password:string

## second model
$ rails generate scaffold Location location_name:string coordinates:json
```

[1]: https://trello.com/invite/b/LLSmtsFl/ed133625c73fabd43e51ee04609c263f/app-development


## Prototype
 [1]: https://www.figma.com/file/KOc5UqZg2ftcQqWEvJlc2Z/Chasing-Stars?node-id=203%3A1392