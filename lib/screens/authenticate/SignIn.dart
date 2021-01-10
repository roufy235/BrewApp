import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        brightness: Brightness.dark,
        centerTitle: true,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      backgroundColor: Colors.brown[100],
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: RaisedButton(
          onPressed: () async {
            dynamic response = await this._auth.signInAnon();
            if (response == null) {
              print('Unable to sign in');
            } else {
              print('successfully signed in');
              print(response.uid);
            }
          },
          child: Text(
            'Sign In Anon',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
