import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'Classes.dart';

class EventsPage extends StatefulWidget {
  EventsPage({
    Key key,
    this.eventsReady,
    this.events,
  }) : super(key: key);

  bool eventsReady;
  List<Event> events;

  @override
  State<StatefulWidget> createState() {
    return new EventsPageState();
  }
}

// class Event {
//   final double startTime;
//   final double endTime;
//   final String description;
//   final String room;
//
//   Event(this.startTime, this.endTime, this.description, this.room);
// }

//List<Event> alo = [
//  new Event(1, 2, 'Lets do a Talk', 'Sala 666'),
//  new Event(1.5, 3, 'jsjsj', 'Sala 666'),
//  new Event(2, 4, 'What', 'Sala 666'),
//  new Event(5, 6, 'What', 'Sala 666')
//];
//
// List<Event> alo = [
//   new Event(
//       id: 1,
//       name: 'Example title',
//       description: 'Description',
//       startTime: '2020-03-23T01:00:00Z',
//       endTime: '2020-03-23T02:00:00Z',
//       updates: '',
//       isBookmarked: true),
//   new Event(
//       id: 1,
//       name: 'Example title 2',
//       description: 'Description 2',
//       startTime: '2020-03-23T03:00:00Z',
//       endTime: '2020-03-23T04:00:00Z',
//       updates: '',
//       isBookmarked: false)
//   // new Event(1, 2, 'Lets do a Talk', 'Sala 666'),
//   // new Event(1.5, 3, 'jsjsj', 'Sala 666'),
//   // new Event(2, 4, 'What', 'Sala 666'),
//   // new Event(5, 6, 'What', 'Sala 666')
// ];
//

class EventsPageState extends State<EventsPage> {
  Map<int, bool> selected = {23: true, 24: false, 25: false, 26: false};
  int selectedDay = 23;

  Widget createEvent(double stackWidth, double startTime, double endTime,
      int index, int family, String text, String room) {
    return new Positioned(
        top: startTime,
        left: index * (stackWidth / family),
        width: stackWidth / family,
        child: Container(
            height: endTime - startTime,
            margin: EdgeInsets.fromLTRB(3, 0, 0, 3),
            decoration: BoxDecoration(),
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child: Container(
                        height: endTime - startTime,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0)),
                        ),
                        width: stackWidth,
                        child: Text(text, textAlign: TextAlign.center))),
                Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.indigo[200],
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Center(
                        child: Text(room, textAlign: TextAlign.center),
                      ),
                    )),
              ],
            )));
  }

  Widget getTextWidgets(List<String> strings, double height) {
    return new Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Column(
            children: strings
                .map((item) => new Flexible(
                    child: Container(
                        height: height,
                        width: height,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                        ))))
                .toList()));
  }

  /* Sets a new selected day */
  void setDay(int day) {
    setState(() {
      selected.forEach((k, v) => selected[k] = false);
      selected[day] = true;
      selectedDay = day;
    });
  }

  final List<String> hours = <String>[
    '0 AM',
    '1 AM',
    '2 AM',
    '3 AM',
    '4 AM',
    '5 AM',
    '6 AM',
    '7 AM',
    '8 AM',
    '9 AM',
    '10 AM',
    '11 AM',
    '12 AM',
    '1 PM',
    '2 PM',
    '3 PM',
    '4 PM',
    '5 PM',
    '6 PM',
    '7 PM',
    '8 PM',
    '9 PM',
    '10 PM',
    '11 PM',
    '12 PM',
  ];

  @override
  Widget build(BuildContext context) {
    double viewWidth = MediaQuery.of(context).size.width;
    double viewHeight = MediaQuery.of(context).size.height;
    double stackWidth = (6 / 7) * viewWidth;
    double hourHeight = (viewHeight / 6) - 3;

    List<List<Event>> makeFamilies(List<Event> allEvents) {
      List<List<Event>> eventsList = [[]];
      bool isFamily = false;
      double startTime;
      double maxEndTime;
      int x = 0;
      int y = -1;
      for (int i = 0; i < allEvents.length; i++) {
        Event elem = allEvents[i];

        if (isFamily) {
          if (elem.parsedStart.hour >= startTime &&
              elem.parsedEnd.hour <= maxEndTime) {
            ++x;
            if (elem.parsedEnd.hour > maxEndTime) {
              maxEndTime = elem.parsedEnd.hour.toDouble() +
                  (elem.parsedEnd.minute.toDouble() / 60);
            }
            eventsList[y].add(elem);
          } else {
            isFamily = false;
          }
        }
        if (!isFamily) {
          List<Event> lista = [];

          x = 0;
          y++;
          maxEndTime = elem.parsedEnd.hour.toDouble() +
              (elem.parsedEnd.minute.toDouble() / 60);
          startTime = elem.parsedStart.hour.toDouble() +
              (elem.parsedStart.minute.toDouble() / 60);
          eventsList.add(lista);
          eventsList[y].add(elem);
          isFamily = true;
        }
      }
      return eventsList;
    }

    List<Positioned> getEvents(List<Event> events) {
      List<Positioned> widgetsEvents = [];

      List<Event> bookmarkedEvents = new List();
      for (var i = 0; i < events.length; i++) {
        if (events[i].isBookmarked &&
            events[i].parsedStart.day == selectedDay) {
          bookmarkedEvents.add(events[i]);
        }
      }

      List<List<Event>> listOfLists = makeFamilies(bookmarkedEvents);

      for (int i = 0; i < listOfLists.length; i++) {
        for (int j = 0; j < listOfLists[i].length; j++) {
          Event event = listOfLists[i][j];
          Positioned widgetEvent = createEvent(
              stackWidth,
              hourHeight *
                  (event.parsedStart.hour + event.parsedStart.minute / 60),
              hourHeight * (event.parsedEnd.hour + event.parsedEnd.minute / 60),
              j,
              listOfLists[i].length,
              event.name,
              "na sala b200");
          widgetsEvents.add(widgetEvent);
        }
      }

      return widgetsEvents;
    }

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, (viewHeight / 8), 0, 0),
              child: SingleChildScrollView(
                child: Container(
                    height: viewHeight * 4.05,
                    child: Row(children: <Widget>[
                      Expanded(
                          flex: 2, child: getTextWidgets(hours, hourHeight)),
                      Expanded(
                          flex: 13,
                          child: Stack(
                            children: getEvents(widget.events),
                          ))
                    ])),
              )),
          Positioned(
            child: new Container(
              height: viewHeight / 8,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20.0)),
              ),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Container(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text('  Mon',
                                          textAlign: TextAlign.center)),
                                  Expanded(
                                      child: Text(' Tue',
                                          textAlign: TextAlign.center)),
                                  Expanded(
                                      child: Text(' Wen',
                                          textAlign: TextAlign.center)),
                                  Expanded(
                                      child: Text(' Thu',
                                          textAlign: TextAlign.center))
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.indigo[800]),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: () => setDay(23),
                                          shape: new CircleBorder(),
                                          fillColor: selected[23]
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('23'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: () => setDay(24),
                                          shape: new CircleBorder(),
                                          fillColor: selected[24]
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('24'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: () => setDay(25),
                                          shape: new CircleBorder(),
                                          fillColor: selected[25]
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('25'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: () => setDay(26),
                                          shape: new CircleBorder(),
                                          fillColor: selected[26]
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('26'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                      ),
                      // Expanded(
                      //     flex: 2,
                      //     child: Container(
                      //       alignment: AlignmentDirectional.centerEnd,
                      //       child: RawMaterialButton(
                      //         onPressed: () {},
                      //         shape: new CircleBorder(),
                      //         fillColor: Colors.orangeAccent,
                      //         child: Text('Add+'),
                      //       ),
                      //     )),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
