# Batatas


## Vision
### Values
User satisfaction is our main concern. To achieve this we will provide a service to our users so that they will never be lost no matter the situation. Building a responsive app is also one of our main pillars because without this value none of the others can exist. Finally our last underlying value is to use the newest cutting edge technology to provide a better navigation service.
### Mission
Our mission is to connect people through a pinpoint GPS so that any person is able to locate themselves inside an event or a conference. By promoting interactivity between attendees and speakers, our main objective is to provide a better overall experience to all participants of the conference. 
### Motto
_Guiding you to success_
## Elevator Pitch
"Hey! So, after this talk there is going to be a workshop in room 212, don't forget to check it out!". But the problem is that the attendees aren't FEUP students, and they don't have directions to the workshop. Our app fixes that.

Solution: We aim to build an internal positioning system to connect people with events and other people, giving them directions to their desired destinations.

Resources: We'll need at least 3 Raspberry Pi or 3 Bluetooth low energy beacons to build our prototype.

### User Stories and Acceptance Tests:
Our user stories are present over at Pivotal Tracker : https://www.pivotaltracker.com/n/projects/2401872

The stories have points assigned, representing the effort of each story, and are ordered by value with the least risk. The acceptance tests are in the description.

### Mockup
Use this link to view the Mockup (bottom bar navigation is functional): https://www.figma.com/proto/0gYmhHxELM9CL42Cf1oU3I/Mobile-App-Design?node-id=1%3A6&scaling=scale-down

### Architecture
#### Architecture / design decisions
For our architecture, we opted for a basic relational schema made up of three different components: backend, mobile app and BLE playground. The mobile app will be how users interact with us, which will be responsible for fetching the backend for updating information, and for scanning the nearby Bluetooth beacons to be able to localize itself.

#### Technology
For our technology, we decided to go with Django as our backend framework, and with Flutter as our mobile app framework.

#### Why Django?
Django is a MVC python web framework built _for perfectionists with deadlines_, as the motto says. At its core, this framework implements the DRY (don't repeat yourself) software principle to the maximum extent, as everything in Django is from it's models. Because of this, it has a simplistic architecture and it's a great candidate for ESOF because of its short learning curve.

#### Why Flutter?
Flutter is a SDK for building apps for several different platforms, but it's mainly used for building mobile apps. Flutter helps in the development of mobile apps as it lets the same codebase be used to build both apps for Android and iOS, leading developers to only needing to learn Flutter instead of two different platform development kits (Android Studio and Xcode).

### Actors:
![Alt text](actors.png?raw=true "Actors")

### Domain Model:
![Alt text](domainModel.png?raw=true "Domain Model")

