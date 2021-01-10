import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/Loading.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  final Function toggleView;

  CreateAccount({this.toggleView});

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();
  String _email = '';
  String _password = '';
  String _error = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.brown[400],
        brightness: Brightness.dark,
        centerTitle: false,
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
                'Sign In',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: this._loading ? Loading() : Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
        child: Form(
          key: this._formKey,
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
                  return 'Enter a password 6+ characters long';
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
                    dynamic result = await this
                        ._auth
                        .registerWithEmailAndPassword(this._email, this._password);
                    if(result == null) {
                        setState(() {
                          this._loading = false;
                          this._error = 'Please supply a valid email address';
                        });
                    }
                  }
                },
                color: Colors.brown,
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              SizedBox(height: 20.0,),
              Text(
                  this._error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
