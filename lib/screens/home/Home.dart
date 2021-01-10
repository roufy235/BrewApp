import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew App'),
        elevation: 0.0,
        centerTitle: false,
        brightness: Brightness.dark,
        backgroundColor: Colors.brown[400],
        actions: [
          FlatButton.icon(
            onPressed: () async {
              await this._auth.signOut();
            },
            label: Text('Logout'),
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: Container(),
    );
  }
}
