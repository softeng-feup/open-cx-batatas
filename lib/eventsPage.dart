import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  final Color color;

  EventsPage(this.color); //constructor

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      color: color,
    );
  }
}