import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_button/progress_button.dart';
import '../../Constants.dart' as Constants;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key key, this.takeToNormalApp}) : super(key: key);

  final dynamic takeToNormalApp;

  @override
  _CreateAccountScreenState createState() =>
      _CreateAccountScreenState(takeToNormalApp);
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final FocusNode _firstNameFocusNode = new FocusNode();
  final FocusNode _lastNameFocusNode = new FocusNode();
  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _usernameFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();

  String firstNameError;
  String lastNameError;
  String emailError;
  String usernameError;
  String passwordError;
  String nonFieldError;

  ButtonState createAccountBtnState;

  dynamic takeToNormalApp;

  _CreateAccountScreenState(this.takeToNormalApp);

  void sendRequest(BuildContext context) async {
    setState(() {
      createAccountBtnState = ButtonState.inProgress;
    });

    firstNameError = null;
    lastNameError = null;
    emailError = null;
    usernameError = null;
    passwordError = null;
    nonFieldError = null;

    final firstNameValue = firstNameController.text;
    final lastNameValue = lastNameController.text;
    final emailValue = emailController.text;
    final usernameValue = usernameController.text;
    final passwordValue = passwordController.text;

    try {
      Dio dio = new Dio();
      final res = await dio.post(Constants.API_URL + 'auth/register/', data: {
        'first_name': firstNameValue,
        'last_name': lastNameValue,
        'email': emailValue,
        'username': usernameValue,
        'password': passwordValue
      });
      setState(() {
        createAccountBtnState = ButtonState.normal;
      });

      // var data = json.decode(res.body);
      var data = res.data;
      String token = data['token'];
      saveTokenToStorage(token);
      this.takeToNormalApp(context);
    } on DioError catch (e) {
      var data = e.response.data;

      var firstNameErrors = data['first_name'] as List;
      if (firstNameErrors != null) {
        firstNameErrors.forEach((err) {
          if (firstNameError == null) {
            firstNameError = err;
          } else {
            firstNameError += '\n' + err;
          }
        });
      }

      var lastNameErrors = data['last_name'] as List;
      if (lastNameErrors != null) {
        lastNameErrors.forEach((err) {
          if (lastNameError == null) {
            lastNameError = err;
          } else {
            lastNameError += '\n' + err;
          }
        });
      }

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

      var usernameErrors = data['username'] as List;
      if (usernameErrors != null) {
        usernameErrors.forEach((err) {
          if (usernameError == null) {
            usernameError = err;
          } else {
            usernameError += '\n' + err;
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
        createAccountBtnState = ButtonState.error;
      });
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
              SizedBox(height: 12),
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
                decoration: InputDecoration(
                    hintText: 'Your first name',
                    labelText: 'First name',
                    errorText: firstNameError,
                    border: OutlineInputBorder()),
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                controller: firstNameController,
                textInputAction: TextInputAction.next,
                focusNode: _firstNameFocusNode,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_lastNameFocusNode),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Your last name',
                    labelText: 'Last name',
                    errorText: lastNameError,
                    border: OutlineInputBorder()),
                textCapitalization: TextCapitalization.sentences,
                controller: lastNameController,
                textInputAction: TextInputAction.next,
                focusNode: _lastNameFocusNode,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_emailFocusNode),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Your email address',
                    labelText: 'Email',
                    errorText: emailError,
                    border: OutlineInputBorder()),
                controller: emailController,
                textInputAction: TextInputAction.next,
                focusNode: _emailFocusNode,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(_usernameFocusNode),
                onSaved: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Your username',
                    labelText: 'Username',
                    errorText: usernameError,
                    border: OutlineInputBorder()),
                controller: usernameController,
                textInputAction: TextInputAction.next,
                focusNode: _usernameFocusNode,
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
                child: Text('Create account',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600)),
                onPressed: () => this.sendRequest(context),
                buttonState: createAccountBtnState,
                backgroundColor: Colors.grey[300],
                progressColor: Theme.of(context).primaryColor,
              ),
            ]))))));
  }
}
