import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth/CreateAccountScreen.dart';
import 'auth/LoginScreen.dart';
import '../animations.dart';

class WelcomeScreen extends StatelessWidget {
  dynamic takeToNormalApp;

  WelcomeScreen(this.takeToNormalApp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xff0f2f7f),
          child: Stack(children: [
            Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '<Programming>',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'Fontin Sans'),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '2020',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 120,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Fontin Sans'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),
                    SizedBox.fromSize(
                      size: Size(200, 44), // button width and height
                      child: Material(
                        color: Colors.grey[300],
                        child: InkWell(
                          splashColor: Colors.orange, // splash color
                          onTap: () {
                            Navigator.push(
                                context,
                                EnterExitRoute(
                                    exitPage:
                                        WelcomeScreen(this.takeToNormalApp),
                                    enterPage: CreateAccountScreen(
                                        this.takeToNormalApp)));
                          }, // button pressed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.userCircle), // icon
                              Text('Create an account',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox.fromSize(
                      size: Size(200, 44), // button width and height
                      child: Material(
                        color: Colors.blue,
                        child: InkWell(
                          splashColor: Colors.orange, // splash color
                          onTap: () {}, // button pressed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(FontAwesomeIcons.userCircle), // icon
                              Text('Sign up with LinkedIn',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)), // text
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Already have an account? ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Fontin Sans')),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    EnterExitRoute(
                                        exitPage:
                                            WelcomeScreen(this.takeToNormalApp),
                                        enterPage:
                                            LoginScreen(this.takeToNormalApp)));
                              },
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Fontin Sans'),
                              )),
                        ]),
                  ]),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Powered by ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                          Text('batatas',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 16,
                                  fontFamily: 'Confortaa'))
                        ])))
          ])),
    );
  }
}
