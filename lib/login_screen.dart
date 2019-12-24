import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
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

            /// Button login
            RaisedButton(
              child: Text('Login'),
              onPressed: _onPressedBtnLogin,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPressedBtnLogin() async {
    if (_formKey.currentState.validate()) {
      try {
        _formKey.currentState.save();
        AuthResult authResult =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(user: authResult.user),
          ),
        );
      } on PlatformException catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
      }
    }
  }
}
