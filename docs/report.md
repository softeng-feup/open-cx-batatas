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

- Alexandre Carqueja
- Carolina Soares
- Christopher Abreu
- Diogo Silva
- Simão Santos

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
## Requirements (to do)

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram (to do, tem imagem so)
![Actors involved with the app](actors.png?raw=true "Actors")

### User stories (to do)

**User interface mockups**.
After the user story text, you should add a draft of the corresponding user interfaces, a simple mockup or draft, if applicable.

**Acceptance tests**.
For each user story you should write also the acceptance tests (textually in Gherkin), i.e., a description of scenarios (situations) that will help to confirm that the system satisfies the requirements addressed by the user story.

**Value and effort**.
At the end, it is good to add a rough indication of the value of the user story to the customers (e.g. [MoSCoW](https://en.wikipedia.org/wiki/MoSCoW_method) method) and the team should add an estimation of the effort to implement it, for example, using t-shirt sizes (XS, S, M, L, XL).

### Domain model

![Domain Model](domainModel.png?raw=true "DomainModel")

---

## Architecture and Design
For our architecture, we opted for a basic relational schema made up of three different components: backend, mobile app and BLE playground. The mobile app will be how users interact with us, which will be responsible for fetching the backend for updating information, and for scanning the nearby Bluetooth beacons to be able to localize itself.

We decided to go with Django as our backend framework, and Flutter as our mobile app framework.

#### Why Django?
Django is a MVC python web framework built for perfectionists with deadlines, as the motto says. At its core, this framework implements the DRY (don't repeat yourself) software principle to the maximum extent, as everything in Django is from it's models. Because of this, it has a simplistic architecture and it's a great candidate for ESOF because of its short learning curve.

#### Why Flutter?
Flutter is a SDK for building apps for several different platforms, but it's mainly used for building mobile apps. Flutter helps in the development of mobile apps as it lets the same codebase be used to build both apps for Android and iOS, leading developers to only needing to learn Flutter instead of two different platform development kits (Android Studio and Xcode).

### Logical architecture (to do, mais uml)
The purpose of this subsection is to document the high-level logical structure of the code, using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

### Physical architecture (to do, falar de beacons)
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams or component diagrams (separate or integrated), showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for openCX are, for example, frameworks for mobile applications (Flutter vs ReactNative vs ...), languages to program with microbit, and communication with things (beacons, sensors, etc.).

### Prototype (to do)
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe in more detail which, and how, user(s) story(ies) were implemented.

---

## Implementation (to do, nao sei bem o que pôr aqui, talvez nao é preciso nada)
While not necessary, sometimes it might be useful to explain a few aspects of the code that have the greatest potential to confuse software engineers about how it works. Since the code should speak by itself, try to keep this section as short and simple as possible.

Use cross-links to the code repository and only embed real fragments of code when strictly needed, since they tend to become outdated very soon.

---
## Test (to do)

There are several ways of documenting testing activities, and quality assurance in general, being the most common: a strategy, a plan, test case specifications, and test checklists.

In this section it is only expected to include the following:
* test plan describing the list of features to be tested and the testing methods and tools;
* test case specifications to verify the functionalities, using unit tests and acceptance tests.
 
A good practice is to simplify this, avoiding repetitions, and automating the testing actions as much as possible.

---
## Configuration and change management (to do)

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).


---

## Project management
In this project we didn't use a specific platform to keep track of our progress, we comunicated in a chat with all of the team members and with the resources we organized in our [wiki](https://github.com/softeng-feup/open-cx-batatas/wiki), we were on a stable track from the beginning. In the wiki, we had [mockups](https://github.com/softeng-feup/open-cx-batatas/wiki/Mockup) and [information on the technologies](https://github.com/softeng-feup/open-cx-batatas/wiki/Learning-material) we were using, some for the very first time.