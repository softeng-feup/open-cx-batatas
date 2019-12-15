import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  BallPulseIndicator animation = BallPulseIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getLoadingContainer(context));
  }

  Container getLoadingContainer(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Loading(indicator: animation, size: 100.0, color: Colors.white),
      ),
    );
  }
}
