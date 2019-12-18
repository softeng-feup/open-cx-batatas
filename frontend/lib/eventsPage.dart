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
        height: endTime - startTime,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                    padding: EdgeInsets.fromLTRB(1, 1, 1, 0),
                    margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    width: stackWidth,
                    child: Text(text, textAlign: TextAlign.center))),
            Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(1, 0, 1, 1),
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(room, textAlign: TextAlign.center),
                  ),
                )),
          ],
        ));
  }

  Widget getTextWidgets(List<String> strings, double height) {
    return new Column(
        children: strings
            .map((item) => new Expanded(
                child: Container(
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border(
                        top: BorderSide(color: Colors.black, width: 1),
                        right: BorderSide(color: Colors.black, width: 1),
                        left: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.left,
                    ))))
            .toList());
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
    '00h00',
    '01h00',
    '02h00',
    '03h00',
    '04h00',
    '05h00',
    '06h00',
    '07h00',
    '08h00',
    '09h00',
    '10h00',
    '11h00',
    '12h00',
    '13h00',
    '14h00',
    '15h00',
    '16h00',
    '17h00',
    '18h00',
    '19h00',
    '20h00',
    '21h00',
    '22h00',
    '23h00',
    '24h00'
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
      int startTime;
      int maxEndTime;
      int x = 0;
      int y = -1;
      for (int i = 0; i < allEvents.length; i++) {
        Event elem = allEvents[i];

        if (isFamily) {
          if (elem.parsedStart.hour >= startTime &&
              elem.parsedEnd.hour <= maxEndTime) {
            ++x;
            if (elem.parsedEnd.hour > maxEndTime) {
              maxEndTime = elem.parsedEnd.hour;
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
          maxEndTime = elem.parsedEnd.hour;
          startTime = elem.parsedEnd.hour;
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
              hourHeight * event.parsedStart.hour,
              hourHeight * event.parsedEnd.hour,
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
                    height: viewHeight * 4,
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
                                margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.blue),
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
