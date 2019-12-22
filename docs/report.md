# openCX-batatas Development Report

Welcome to the documentation pages of the Marauder's Mapp of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you, from the team!

- [Alexandre Carqueja](https://github.com/WALEX2000)
- [Carolina Soares](https://github.com/mcarolinaSoares)
- [Christopher Abreu](https://github.com/cfa911)
- [Diogo Silva](https://github.com/iamdiogo)
- [Simão Santos](https://github.com/Simao-Santos)

---

## Product Vision
User satisfaction is our main concern. To achieve this we will provide a service to our users so that they will never be lost no matter the situation. Building a responsive app is also one of our main pillars because without this value none of the others can exist. Finally our last underlying value is to use the newest cutting edge technology to provide a better navigation service.

Our mission is to connect people through a pinpoint GPS so that any person is able to locate themselves inside an event or a conference. By promoting interactivity between attendees and speakers, our main objective is to provide a better overall experience to all participants of the conference.

**Guiding you to success**

---
## Elevator Pitch
"Hey! So, after this talk there is going to be a workshop in room 212, don't forget to check it out!". But the problem is that the attendees aren't FEUP students, and they don't have directions to the workshop. Our app fixes that.

Solution: We aim to build an internal positioning system to connect people with events and other people, giving them directions to their desired destinations.

Resources: We'll need at least 3 Raspberry Pi or 3 Bluetooth low energy beacons to build our prototype.

---
## Requirements

### Use case diagram
![Use case diagram](usecases.png?raw=true "usecases")


![Actors involved with the app](actors.png?raw=true "Actors")


### User stories

- As a user, I want to view a calendar containing all my bookmarked events so that I know what I found interesting.
- As a user, I want to bookmark an event so that I can easily find it later.
- As a user, I want to view my profile information so that I can check my information.
- As a user, I want to view all the events of the conference so that I can choose which ones to attend.
- As a user I want to be able to search for rooms and see them on the map, so that I can understand where they are located.
- As a user I want t see my location inside the building so that I can understand where I am.
- As a user, I want to have directions to a conference event so that I am able to attend the event.

### Domain model

![Domain Model](domainModel.png?raw=true "DomainModel")

---

## Architecture and Design
For our architecture, we opted for a basic relational schema made up of three different components: backend, mobile app and BLE playground. The mobile app will be how users interact with us, which will be responsible for fetching the backend for updating information, and for scanning the nearby Bluetooth beacons to be able to localize itself.

### Logical architecture
![Logical Architecture](architecture_logical.png?raw=true "LogicalArchitecture")

We decided to go with Django as our backend framework, and Flutter as our mobile app framework.

#### Why Django?
Django is a MVC python web framework built for perfectionists with deadlines, as the motto says. At its core, this framework implements the DRY (don't repeat yourself) software principle to the maximum extent, as everything in Django is from it's models. Because of this, it has a simplistic architecture and it's a great candidate for ESOF because of its short learning curve.

#### Why Flutter?
Flutter is a SDK for building apps for several different platforms, but it's mainly used for building mobile apps. Flutter helps in the development of mobile apps as it lets the same codebase be used to build both apps for Android and iOS, leading developers to only needing to learn Flutter instead of two different platform development kits (Android Studio and Xcode).

### Physical architecture
#### Bluetooth Low Energy beacons
In terms of our physical architecture, our project requires the existence of Bluetooth Low Energy (BLE) beacons in the space we want to give directions at. These devices make it possible to properly localize a user anywhere at the conference, as long as they are properly distributed at the venue so that, at any given place, there are always 3 beacons distanced less than 100 meters from the user.

### Prototype
Our application allows a user to get direction to any class a lecture/workshop is taking place by typing in the room in the search bar to compute the path.

This means that we concluded almost every user story we planned to do. Unfortunately we had to choose to leave the ability to connect users with each other and diferenciate different types of users (speaker, attendee).

However all the other user stories were concluded with success.

---

## Implementation
To understand the Implementation and structure of our project it is important to know that it has been divided into 3 independent part, which correspond to in-app pages, accessibble through the bottom bar.
Depending on which button is selected a different body will be displayed here:: https://github.com/softeng-feup/open-cx-batatas/blob/b064b77c44782337e48ead2d43d5d9ab86aba297/frontend/lib/main.dart#L259-L262

 For the Map page all it's code is located on the file [mapPage.dart](https://github.com/softeng-feup/open-cx-batatas/blob/master/frontend/lib/mapPage.dart).
 On the map page, the hardest part to understand are the calculations we make to locate our user inside FEUP using BLE devices. We go about this by locating the nearest 3 devices the user can connect to from their phone (as of now this happens every 10 seconds), and then calculating the intersections between the 3 circles you get from that distance. https://github.com/softeng-feup/open-cx-batatas/blob/b064b77c44782337e48ead2d43d5d9ab86aba297/frontend/lib/mapPage.dart#L401-L408
 Of course to do this we must first know the coordinates of each beacon, which we fetch when the application first loads.
 
 On the profile page we simply display the user's information, as such there is no "logic" in this part of our project.
 The same goes for the events page.
 
 On the backend we've determined that everything is self explanatory, as such there's no need for further explanations.

---
## Test
During the development of this project we resorted to Gherkin to create tests for each feature. These tests can be seen in the description of each user story, which were created on [Pivotal Tracker](https://www.pivotaltracker.com/n/projects/2401872).

---
## Configuration and change management
When developing this project we created several seperations through the use of branches. Namely between the frontend and backend.
Inside the frontend we also seperated each page in its own branch, so make it easier to make each feature independent from one another.
In the end we've merged everything on the master branch to make it ready for release.

---

## Project management
In this project we used Pivotal Tracker to manage our progress and assign tasks to people, we also comunicated in a chat with all of the team members and with the resources we organized in our [wiki](https://github.com/softeng-feup/open-cx-batatas/wiki), we were on a stable track from the beginning. In the wiki, we had [mockups](https://github.com/softeng-feup/open-cx-batatas/wiki/Mockup) and [information on the technologies](https://github.com/softeng-feup/open-cx-batatas/wiki/Learning-material) we were using, some for the very first time.
