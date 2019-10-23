import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final Color color;

  ProfilePage(this.color); //constructor

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      color: color,
    );
  }
}