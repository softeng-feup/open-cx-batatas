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
  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.grey,
            child: Row(
              children: <Widget>[
                Flexible(
                    child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
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
                                        fillColor: three ? Colors.orangeAccent : Colors.white,
                                        child: Text('23'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: setFour,
                                        shape: new CircleBorder(),
                                        fillColor: four ? Colors.orangeAccent : Colors.white,
                                        child: Text('24'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: setFive,
                                        shape: new CircleBorder(),
                                        fillColor: five ? Colors.orangeAccent : Colors.white,
                                        child: Text('25'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: setSix,
                                        shape: new CircleBorder(),
                                        fillColor: six ? Colors.orangeAccent : Colors.white,
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
          child: Container(),
        )
      ],
    );
  }
}

/*
  child: Row(
        children: [
          // 2 children
              Row(
            children: [
              floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
                ),
            
          ],),
          Text(
        '170 ws',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ), 
        ),
        ],
      ),
*/
