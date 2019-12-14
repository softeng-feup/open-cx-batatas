import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../colors.dart';

class LoginScreen extends StatelessWidget {
  final takeToNormalApp;

  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();

  LoginScreen(this.takeToNormalApp);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment(0.0, 0.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: SingleChildScrollView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.chevronLeft),
                  alignment: Alignment.topLeft,
                  tooltip: 'Go back',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ]),
              SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  '<Programming> 2020',
                  style: TextStyle(
                      color: MaterialColor(0xff0f2f7f, programmingColor),
                      fontSize: 20,
                      fontFamily: 'Fontin Sans'),
                  textAlign: TextAlign.center,
                ),
              ]),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Log In',
                    style: TextStyle(fontFamily: 'Fontin Sans', fontSize: 30)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Welcome back!',
                    style: TextStyle(fontFamily: 'Fontin Sans', fontSize: 14)),
              ]),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Your email address',
                    labelText: 'Email',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_passwordFocusNode),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocusNode,
                obscureText: true,
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 20),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                buttonColor: Colors.grey[300],
                child: RaisedButton(
                  onPressed: () => this.takeToNormalApp(context),
                  child: Text('Login', style: TextStyle(color: Colors.black)),
                ),
              )
            ])))));
  }
}
