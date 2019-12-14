import 'package:flutter/material.dart';
import '../../colors.dart';

class LoginScreen extends StatelessWidget {
  final takeToNormalApp;

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
