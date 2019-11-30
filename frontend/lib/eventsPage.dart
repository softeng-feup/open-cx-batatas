import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Flexible(
          child: Container(
            height: 80.0,
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
                               Expanded(child: Text('  Mon',textAlign: TextAlign.center)),
                               Expanded(child: Text(' Tue',textAlign: TextAlign.center)),
                               Expanded(child: Text(' Wen',textAlign: TextAlign.center)),
                               Expanded(child: Text(' Thu',textAlign: TextAlign.center))

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
                                        onPressed: () {},
                                        shape: new CircleBorder(),
                                        fillColor: Colors.white,
                                        child: Text('23'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: () {},
                                        shape: new CircleBorder(),
                                        fillColor: Colors.orangeAccent,
                                        child: Text('24'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: () {},
                                        shape: new CircleBorder(),
                                        fillColor: Colors.white,
                                        child: Text('25'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: RawMaterialButton(
                                        onPressed: () {},
                                        shape: new CircleBorder(),
                                        fillColor: Colors.white,
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
