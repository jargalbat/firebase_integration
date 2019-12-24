import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/home_screen.dart';
import 'package:firebase_integration/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign up')),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// Email
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onSaved: (value) => _email = value,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please type an email';
                }
                return null;
              },
              initialValue: 'test@gmail.com',
            ),

            /// Password
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
              onSaved: (value) => _password = value,
              validator: (value) {
                if (value.length < 6) {
                  return 'Your password needs to be atleast 6 characters';
                }
                return null;
              },
              obscureText: true,
              initialValue: '123qwe',
            ),

            /// Button sign up
            RaisedButton(
              child: Text('Sign up'),
              onPressed: _onPressedBtnSignUp,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedBtnSignUp() async {
    if (_formKey.currentState.validate()) {
      try {
        _formKey.currentState.save();

        // Sign up
        AuthResult authResult =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        // Email verification
        authResult.user.sendEmailVerification();

        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } on PlatformException catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
