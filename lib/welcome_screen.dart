import 'package:firebase_integration/login_screen.dart';
import 'package:firebase_integration/sign_up_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
//  final _scaffoldKey = new GlobalKey<ScaffoldKey>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /// Login
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                  fullscreenDialog: true,
                ),
              );
            },
            child: Text('Login'),
          ),

          /// Sign up
          RaisedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                    fullscreenDialog: true,
                  ));
            },
            child: Text('Sign up'),
          ),
        ],
      ),
    );
  }
}
