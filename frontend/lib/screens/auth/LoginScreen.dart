import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_button/progress_button.dart';
import '../../Constants.dart' as Constants;
import '../../colors.dart';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.takeToNormalApp}) : super(key: key);

  final dynamic takeToNormalApp;

  @override
  _LoginScreenState createState() => _LoginScreenState(takeToNormalApp);
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();

  String emailError;
  String passwordError;
  String nonFieldError;

  ButtonState loginBtnState;

  dynamic takeToNormalApp;

  _LoginScreenState(this.takeToNormalApp);

  void sendRequest(BuildContext context) async {
    setState(() {
      loginBtnState = ButtonState.inProgress;
    });

    emailError = null;
    passwordError = null;
    nonFieldError = null;

    final emailValue = emailController.text;
    final passwordValue = passwordController.text;

    final res = await http.post(Constants.API_URL + 'auth/login/',
        body: {'email': emailValue, 'password': passwordValue});

    if (res.statusCode == 400) {
      var data = json.decode(res.body);

      var emailErrors = data['email'] as List;
      if (emailErrors != null) {
        emailErrors.forEach((err) {
          if (emailError == null) {
            emailError = err;
          } else {
            emailError += '\n' + err;
          }
        });
      }

      var passwordErrors = data['password'] as List;
      if (passwordErrors != null) {
        passwordErrors.forEach((err) {
          if (passwordError == null) {
            passwordError = err;
          } else {
            passwordError += '\n' + err;
          }
        });
      }

      var nonFieldErrors = data['non_field_errors'] as List;
      if (nonFieldErrors != null) {
        nonFieldErrors.forEach((err) {
          if (nonFieldError == null) {
            nonFieldError = err;
          } else {
            nonFieldError += '\n' + err;
          }
        });

        Fluttertoast.showToast(
            msg: nonFieldError,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2);
      }

      setState(() {
        loginBtnState = ButtonState.error;
      });
    } else if (res.statusCode == 200) {
      setState(() {
        loginBtnState = ButtonState.normal;
      });

      var data = json.decode(res.body);
      String token = data['token'];
      print(token);
      // saveTokenToStorage(token);
      this.takeToNormalApp(context);
    }
  }

  void saveTokenToStorage(String tokenValue) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File tokenFile = File('$path/token.txt');
    tokenFile.writeAsString(json.encode({'token': tokenValue}));
  }

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
                    child: Form(
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
                decoration: InputDecoration(
                    hintText: 'Your email address',
                    labelText: 'Email',
                    errorText: emailError,
                    border: OutlineInputBorder()),
                autofocus: true,
                controller: emailController,
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
                decoration: InputDecoration(
                    hintText: 'Password',
                    labelText: 'Password',
                    errorText: passwordError,
                    border: OutlineInputBorder()),
                controller: passwordController,
                textInputAction: TextInputAction.done,
                focusNode: _passwordFocusNode,
                obscureText: true,
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 20),
              ProgressButton(
                child: Text('Login',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                onPressed: () => this.sendRequest(context),
                buttonState: loginBtnState,
                backgroundColor: Colors.grey[300],
                progressColor: Theme.of(context).primaryColor,
              ),
            ]))))));
  }
}
