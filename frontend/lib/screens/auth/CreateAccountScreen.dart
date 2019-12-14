import 'package:flutter/material.dart';
import '../../colors.dart';

class CreateAccountScreen extends StatelessWidget {
  final takeToNormalApp;

  CreateAccountScreen(this.takeToNormalApp);

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
                Text('Create an account',
                    style: TextStyle(fontFamily: 'Fontin Sans', fontSize: 30)),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('You\'re one step away to start using the app!',
                    style: TextStyle(fontFamily: 'Fontin Sans', fontSize: 14)),
              ]),
              SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Your first name',
                    labelText: 'First name',
                    border: OutlineInputBorder()),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Your last name',
                    labelText: 'Last name',
                    border: OutlineInputBorder()),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
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
                    hintText: 'Your username',
                    labelText: 'Username',
                    border: OutlineInputBorder()),
                textInputAction: TextInputAction.continueAction,
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
                  child: Text('Create account',
                      style: TextStyle(color: Colors.black)),
                ),
              )
            ])))));
  }
}
