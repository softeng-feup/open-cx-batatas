import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Container(
      child: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Center(),
            ],
          ),
        ],
      ),
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
