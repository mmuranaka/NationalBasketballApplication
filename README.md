# National Basketball Association Application

## 1. Overview

The National Basketball Application is a mobile app designed to enhance user engagement with basketball league data through an intuitive and dynamic interface. Built using Dart and Flutter, the app leverages a RESTful API to import real-time data, including team standings, player stats, and team locations.

## 2. Feature Overview

The app includes three primary pages:

1. **Map Page**: Visualizes all teams' locations on a map. Users can select a favorite team, triggering a special animation for that team, and click on any team to view detailed information about that team's players and stats. The Map Page acts as a home page for the application and contains a drawer allowing the user to navigate to the Standings Page.

2. **Standings Page**: Displays up-to-date standings across the league, showing each team’s record, win percentage, and ranking. Further, this screen contains a drawer allowing the user to view the league standings from any season following 2018.

3. **Team Information Page**: Displays team-specific details, including conference, divsion, and the team's active roster. The roster information displays players information including their number, name, position, height, weight, college, and years in the league. 

## 3. Important Files

Most of the files in the repository are required for running (The application is made for macos simulator through Xcode). 

The following are file related to different pages of the application:

1. *lib/main.dart* is the start of the execution flow of the program
2. *lib/views/HomePage.dart* is the page the main files takes the user on startup, this displays the Map Page
3. *lib/views/Standings.dart* is the Standings Page
4. *lib/views/TeamPage.dart* is the Team Information Page
5. *lib/views/UserDrawer.dart* is the drawer that can be opened from the Map Page, allows for navigation between Map and Standings Page

The following are files that help with some of the low-level functionality of the application:
1. *lib/utils/db_helper.dart* includes simple functions used with sqflite allowing for on-device storage of frequently accessed information
2. *lib/models/team.dart* is a class definition for a team used for adding team information to the on-device sqflite database.