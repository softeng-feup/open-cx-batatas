import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'profilePage.dart';
import 'mapPage.dart';
import 'eventsPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'screens/WelcomeScreen.dart';
import 'package:http/http.dart' as http;
import 'Constants.dart' as Constants;
import 'Auth.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'screens/LoadingScreen.dart';
import 'allEventsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "<Programming> 2020",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xff0f2f7f, programmingColor),
      ),
      home: MyHomePage(title: "<Programming> 2020"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MapPage(),
    EventsPage(),
    AllEventsPage(),
    ProfilePage(),
  ];

  /*
     0 - loading
     1 - is logged out
     2 - is logged in
  */
  int currentState;
  bool hasSeenOnboarding;

  @override
  void initState() {
    super.initState();
    currentState = 0;
    hasSeenOnboarding = false;
    fetchAppState();
  }

  /* Gets token information from storage */
  Future<String> getTokenFromStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File tokenFile = File('$path/token.txt');

    try {
      String tokenFileContents = await tokenFile.readAsString();
      Map<String, dynamic> tokenJson = json.decode(tokenFileContents);
      return tokenJson['token'].toString();
    } catch (e) {
      return null;
    }
  }

  /* Refreshes the app's state based on what was saved */
  void fetchAppState() async {
    String token = await getTokenFromStorage();
    if (token == null) {
      setState(() {
        currentState = 1;
      });
    } else {
      setState(() {
        currentState = 2;
      });
    }
  }

  Scaffold get normalScreen {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title, style: TextStyle(fontFamily: 'Fontin Sans')),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: changePage,
        type: BottomNavigationBarType.fixed, // isto foi a correção: https://github.com/flutter/flutter/issues/13642
        selectedItemColor: new Color.fromRGBO(0, 0, 0, 1.0),
        unselectedItemColor: new Color.fromRGBO(0, 0, 0, 0.3),
        backgroundColor: new Color.fromRGBO(255, 255, 255, 1.0),
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Map'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text('Events')),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Profile'),
            icon: new Icon(Icons.calendar_today),
            title: new Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_circle),
            title: new Text('Hey'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case 0:
        return LoadingScreen();
      case 1:
        return WelcomeScreen(this.takeToNormalApp);
      case 2:
        return normalScreen;
    }
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<dynamic> requestUserData() async {
    String token = await getTokenFromStorage();
    if (token == null) {
      return null;
    }

    final res = await http.get(Constants.API_URL + 'profile/', headers: {
      'Authorization': 'Token ' + token,
      'Content-Type': 'application/json'
    });
    return json.decode(res.body);
  }

  void takeToNormalApp(context) {
    this.setState(() {
      this.currentState = 0;
      Navigator.pop(context);
    });
    new Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        this.currentState = 2;
      });
      this.requestUserData().then((json) {
        Fluttertoast.showToast(
            msg: 'Welcome ' + json['first_name'],
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2);
      });
    });
  }
}
