import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventsPageState();
  }
}

class EventObject {
  final double startTime;
  final double endTime;
  final int family;
  final int index;
  final String description;
  final String room;

  EventObject(this.startTime, this.endTime, this.family, this.index,
      this.description, this.room);
}

class Event {
  final double startTime;
  final double endTime;
  final String description;
  final String room;

  Event(this.startTime, this.endTime, this.description, this.room);
}

List<Event> alo = [
  new Event(1, 2, 'Lets do a Talk', 'Sala 666'),
  new Event(1.5, 3, 'jsjsj', 'Sala 666'),
  new Event(2, 4, 'What', 'Sala 666'),
  new Event(5, 6, 'What', 'Sala 666')
];

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 200,
      alignment: Alignment.topLeft,
      child: Text(text),
      color: Colors.grey[300],
    );
  }
}

class SomeWidget extends StatelessWidget {
  final String text;

  SomeWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      height: 200,
      width: 300,
      alignment: Alignment.topRight,
      child: Text(text),
      color: Colors.grey[300],
    );
  }
}

bool three = false;
bool four = false;
bool five = false;
bool six = false;

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

class EventsPageState extends State<StatefulWidget> {
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

  void setThree() {
    setState(() {
      three = true;
      five = false;
      four = false;
      six = false;
    });
  }

  void setFour() {
    setState(() {
      three = false;
      five = false;
      four = true;
      six = false;
    });
  }

  void setFive() {
    setState(() {
      three = false;
      five = true;
      four = false;
      six = false;
    });
  }

  void setSix() {
    setState(() {
      three = false;
      five = false;
      four = false;
      six = true;
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

  final List<String> events = <String>[
    'JavaScript Workshop - B323',
    '3D Printing Talk - B002',
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
          if (elem.startTime >= startTime && elem.startTime <= maxEndTime) {
            ++x;
            if (elem.endTime > maxEndTime) {
              maxEndTime = elem.endTime;
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
          maxEndTime = elem.endTime;
          startTime = elem.startTime;
          eventsList.add(lista);
          eventsList[y].add(elem);
          isFamily = true;
        }
      }
      return eventsList;
    }

    List<Positioned> getEvents(List<Event> events) {
      List<Positioned> widgetsEvents = [];
      List<List<Event>> listOfLists = makeFamilies(events);
      for (int i = 0; i < listOfLists.length; i++) {
        for (int j = 0; j < listOfLists[i].length; j++) {
          Event event = listOfLists[i][j];
          Positioned widgetEvent = createEvent(
              stackWidth,
              hourHeight * event.startTime,
              hourHeight * event.endTime,
              j,
              listOfLists[i].length,
              event.description,
              event.room);
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
                            children: getEvents(alo),
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
                                          onPressed: setThree,
                                          shape: new CircleBorder(),
                                          fillColor: three
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('23'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: setFour,
                                          shape: new CircleBorder(),
                                          fillColor: four
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('24'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: setFive,
                                          shape: new CircleBorder(),
                                          fillColor: five
                                              ? Colors.orangeAccent
                                              : Colors.white,
                                          child: Text('25'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: RawMaterialButton(
                                          onPressed: setSix,
                                          shape: new CircleBorder(),
                                          fillColor: six
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
                      Expanded(
                          flex: 2,
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            child: RawMaterialButton(
                              onPressed: () {},
                              shape: new CircleBorder(),
                              fillColor: Colors.orangeAccent,
                              child: Text('Add+'),
                            ),
                          )),
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
