import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/Loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';
  String _error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        brightness: Brightness.dark,
        centerTitle: false,
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Create Account',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      backgroundColor: Colors.brown[100],
      body: this._loading ? Loading() : Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: this._email,
                validator: (val) {
                  if (val.isNotEmpty) {
                    return null;
                  }
                  return 'Email is required';
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (val) {
                  setState(() => this._email = val);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                initialValue: this._password,
                validator: (val) {
                  if (val.length > 6) {
                    return null;
                  }
                  return 'At least 6 characters';
                },
                decoration: InputDecoration(hintText: 'Password'),
                obscureText: true,
                onChanged: (val) {
                  setState(() => this._password = val);
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  if (this._formKey.currentState.validate()) {
                    setState(() {
                      this._loading = true;
                    });
                    dynamic response = await this
                        ._auth
                        .signInWithEmailAndPassword(
                        this._email, this._password);
                    if (response == null) {
                      setState(() {
                        this._loading = false;
                        this._error = 'Invalid email and password';
                      });
                    }
                  }
                },
                color: Colors.brown,
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(this._error),
            ],
          ),
        ),
      ),
    );
  }
}
