import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventsPageState();
  }
}

class Event {
  static int startTime;
  static int endTime;
  static String description;
  static String room;
}

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

Widget getTextWidgets(List<String> strings) {
  return new Column(
      children: strings
          .map((item) => new Expanded(
              child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border(
                      right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                      bottom:
                          BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                    ),
                  ),
                  child: Text(
                    item,
                    textAlign: TextAlign.left,
                  ))))
          .toList());
}

Widget getEvents(List<String> strings) {
  return new Column(
      children: strings
          .map((item) => new Expanded(
              child: Container(
                  margin: EdgeInsets.all(20),
                  height: 100,

                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.blue[300],
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        item,
                        textAlign: TextAlign.center,
                      )),
                      Expanded(
                        child: Container(
                          color: Colors.blue[100],
                          height: 30,
                          width: 1000,
                        ),
                      )
                    ],
                  ))))
          .toList());
}

class EventsPageState extends State<StatefulWidget> {
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
    '08h00',
    '10h00',
    '12h00',
    '14h00',
    '16h00',
    '18h00',
    '20h00'
  ];

  final List<String> events = <String>[
    'JavaScript Workshop - B323',
    '3D Printing Talk - B002',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 90, 0, 0),
            child: 
          SingleChildScrollView(
            child: Container(height:600,child:Row(children: <Widget>[
              Expanded(flex:1,child: getTextWidgets(hours)),
              Expanded(flex:4,child: getEvents(events))
            ])),
          )),
          Positioned(
            child: new Container(
              height: MediaQuery.of(context).size.height * 0.15,
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
