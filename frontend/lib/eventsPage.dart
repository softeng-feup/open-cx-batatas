import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new EventsPageState();
  }
}

bool three = false;
bool four = false;
bool five = false;
bool six = false;

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

  final List<String> entries = <String>[
    '',
    '08h00',
    '10h00',
    '12h00',
    '14h00',
    '16h00',
    '18h00',
    '20h00'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView.builder(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context,int index) {
              return Container(
                height: 100,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: Colors.grey[300],border: Border(top: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)))),
                child: Text(
                  '${entries[index]}',
                  textAlign: TextAlign.center,
                ),
              );
            }),
            
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
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
        Flexible(
          flex: 5,
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    color: Color.fromRGBO(50, 50, 50, 0.3),
                    child: Column(
                      children: <Widget>[
                        Expanded(child: Text('08h00')),
                        Expanded(child: Text('10h00')),
                        Expanded(child: Text('12h00')),
                        Expanded(child: Text('14h00')),
                        Expanded(child: Text('16h00')),
                        Expanded(child: Text('18h00')),
                        Expanded(child: Text('20h00')),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    color: Colors.white,
                  ))
            ],
          ),
        )
      ],
    );
  }
}
