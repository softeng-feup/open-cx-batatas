import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  final Color color;

  MapPage(this.color); //constructor

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      color: color,
    );
  }
}